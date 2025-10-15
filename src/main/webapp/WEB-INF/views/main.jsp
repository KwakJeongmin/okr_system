<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OKR 시스템 - 대시보드</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.js"></script>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.6.0/axios.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- axios 로드 후에 ems-core-init.js 로드 -->
	<script src="/lib/js/ems-core-init.js"></script>
    
    <style>
        :root {
            --primary-color: #3b82f6;
            --primary-dark: #2563eb;
            --primary-light: #60a5fa;
            --secondary-color: #06b6d4;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --sidebar-width: 280px;
            --bg-primary: #f8fafc;
            --bg-secondary: #f1f5f9;
            --text-primary: #0f172a;
            --text-secondary: #64748b;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: var(--bg-primary);
            margin: 0;
            padding: 0;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        
        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: var(--sidebar-width);
            background: white;
            padding: 32px 0;
            border-right: 1px solid #e2e8f0;
            z-index: 1000;
            box-shadow: 2px 0 12px rgba(0,0,0,0.05);
        }
        
        .sidebar-header {
            padding: 0 24px 24px;
            border-bottom: 1px solid #e2e8f0;
            margin-bottom: 32px;
        }
        
        .sidebar-header h3 {
            margin: 0;
            font-weight: 800;
            font-size: 1.5rem;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .sidebar-header h3 i {
            color: var(--primary-color);
        }
        
        .sidebar-header p {
            margin: 8px 0 0;
            font-size: 0.875rem;
            color: var(--text-secondary);
        }
        
        .sidebar-menu {
            list-style: none;
            padding: 0 16px;
            margin: 0;
        }
        
        .sidebar-menu li {
            margin: 4px 0;
        }
        
        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 14px 16px;
            color: var(--text-secondary);
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border-radius: 12px;
            font-weight: 500;
            font-size: 0.9375rem;
            position: relative;
        }
        
        .sidebar-menu a::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            width: 4px;
            height: 100%;
            background: var(--primary-color);
            transform: scaleY(0);
            transition: transform 0.3s ease;
            border-radius: 0 4px 4px 0;
        }
        
        .sidebar-menu a:hover {
            background: rgba(59, 130, 246, 0.08);
            color: var(--primary-color);
        }
        
        .sidebar-menu a.active {
            background: rgba(59, 130, 246, 0.12);
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .sidebar-menu a.active::before {
            transform: scaleY(1);
        }
        
        .sidebar-menu i {
            margin-right: 14px;
            font-size: 1.25rem;
            width: 24px;
        }
        
        /* Main Content */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 30px;
            min-height: 100vh;
        }
        
        /* Top Bar */
        .top-bar {
            background: white;
            padding: 24px 32px;
            border-radius: 16px;
            margin-bottom: 32px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid #e2e8f0;
        }
        
        .top-bar h1 {
            margin: 0;
            font-size: 2rem;
            color: var(--text-primary);
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .top-bar h1 i {
            color: var(--primary-color);
        }
        
        .top-bar-actions {
            display: flex;
            gap: 10px;
        }
        
        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px 16px;
            background: var(--bg-secondary);
            border-radius: 8px;
        }
        
        .user-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }
        
        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
            margin-bottom: 32px;
        }
        
        .stat-card {
            background: white;
            padding: 24px;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            transition: all 0.2s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            border-color: var(--primary-color);
        }
        
        .stat-card-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 16px;
        }
        
        .stat-card-icon {
            width: 52px;
            height: 52px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            transition: all 0.2s ease;
        }
        
        .stat-card:hover .stat-card-icon {
            transform: scale(1.1);
        }
        
        .stat-card-icon.primary {
            background: rgba(59, 130, 246, 0.1);
            color: var(--primary-color);
        }
        
        .stat-card-icon.success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }
        
        .stat-card-icon.warning {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }
        
        .stat-card-icon.info {
            background: rgba(6, 182, 212, 0.1);
            color: var(--secondary-color);
        }
        
        .stat-card-title {
            font-size: 0.9375rem;
            color: var(--text-secondary);
            margin-bottom: 8px;
            font-weight: 500;
        }
        
        .stat-card-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 12px;
            line-height: 1;
        }
        
        .stat-card-footer {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 0.875rem;
            color: var(--text-secondary);
            font-weight: 500;
        }
        
        .trend-up {
            color: var(--success-color);
            display: flex;
            align-items: center;
            gap: 4px;
            font-weight: 600;
        }
        
        .trend-down {
            color: var(--danger-color);
            display: flex;
            align-items: center;
            gap: 4px;
            font-weight: 600;
        }
        
        /* OKR Cards */
        .okr-section {
            background: white;
            padding: 24px;
            border-radius: 16px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-bottom: 32px;
            border: 1px solid #e2e8f0;
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 2px solid #f1f5f9;
        }
        
        .section-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-primary);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .section-title i {
            color: var(--primary-color);
        }
        
        .okr-card {
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 20px;
            transition: all 0.2s ease;
            background: white;
        }
        
        .okr-card:hover {
            border-color: var(--primary-color);
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            transform: translateY(-2px);
        }
        
        .okr-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 16px;
        }
        
        .okr-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-primary);
            margin: 0 0 12px 0;
            line-height: 1.4;
        }
        
        .okr-category {
            display: inline-block;
            padding: 4px 10px;
            background: var(--primary-color);
            color: white;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            margin-bottom: 8px;
        }
        
        .okr-status {
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 0.8125rem;
            font-weight: 700;
            white-space: nowrap;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .okr-status.on-track {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }
        
        .okr-status.at-risk {
            background: #fed7aa;
            color: #92400e;
            border: 1px solid #fdba74;
        }
        
        .okr-status.off-track {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }
        
        .okr-progress {
            margin: 16px 0;
        }
        
        .progress-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 0.875rem;
            color: var(--text-secondary);
            font-weight: 500;
        }
        
        .progress-header span:last-child {
            font-weight: 600;
            color: var(--primary-color);
        }
        
        .progress-bar-container {
            height: 8px;
            background: var(--bg-secondary);
            border-radius: 10px;
            overflow: hidden;
        }
        
        .progress-bar-fill {
            height: 100%;
            background: var(--primary-color);
            border-radius: 10px;
            transition: width 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .progress-bar-fill.success {
            background: var(--success-color);
        }
        
        .progress-bar-fill.warning {
            background: var(--warning-color);
        }
        
        .progress-bar-fill.danger {
            background: var(--danger-color);
        }
        
        .key-results {
            margin-top: 16px;
            padding-top: 16px;
            border-top: 1px solid #f1f5f9;
        }
        
        .key-result-item {
            display: flex;
            align-items: start;
            gap: 12px;
            padding: 12px 0;
            border-bottom: 1px solid #f8fafc;
        }
        
        .key-result-item:last-child {
            border-bottom: none;
        }
        
        .kr-checkbox {
            width: 18px;
            height: 18px;
            border: 2px solid #cbd5e1;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-top: 2px;
        }
        
        .kr-checkbox:hover {
            border-color: var(--primary-color);
            transform: scale(1.1);
        }
        
        .kr-checkbox.completed {
            background: var(--success-color);
            border-color: var(--success-color);
            color: white;
        }
        
        .kr-checkbox i {
            font-size: 0.625rem;
        }
        
        .kr-text {
            flex: 1;
            font-size: 0.9375rem;
            color: var(--text-primary);
            font-weight: 500;
            line-height: 1.4;
        }
        
        .kr-value {
            font-weight: 600;
            color: var(--primary-color);
            font-size: 0.875rem;
        }
        
        /* Buttons */
        .btn-primary-custom {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 14px 28px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 0.9375rem;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 2px 8px rgba(59, 130, 246, 0.25);
        }
        
        .btn-primary-custom:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }
        
        .btn-outline-custom {
            background: white;
            color: var(--text-secondary);
            border: 1px solid #e2e8f0;
            padding: 10px 20px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.2s ease;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        
        .btn-outline-custom:hover {
            border-color: var(--primary-color);
            color: var(--primary-color);
            background: rgba(59, 130, 246, 0.05);
        }
        
        /* Chart Container */
        .chart-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            margin-bottom: 32px;
        }
        
        @media (max-width: 992px) {
            .chart-container {
                grid-template-columns: 1fr;
            }
        }
        
        .chart-card {
            background: white;
            padding: 24px;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            transition: all 0.2s ease;
        }
        
        .chart-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            border-color: var(--primary-color);
        }
        
        .chart-card h3 {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .chart-card h3 i {
            color: var(--primary-color);
            font-size: 1.25rem;
        }
    </style>
</head>
<body>
	<script>
	/**************************************************
	* Ready
	**************************************************/
	jQuery(document).ready(function() {
		fncGetTestList();
	});
	
	/**************************************************
	*  FUNCTION 명 : fncGetTestList
	*  FUNCTION 기능설명 : 데이터 목록 조회 테스트
	**************************************************/
	function fncGetTestList() {
	    var params = new Object();
	    
		axiosInstance.get("/test/testLstInqr", {params})
		.then(function (response) {
			if(response.data.status == 200) {
				let dataList = response.data.data.list;	
				console.log(dataList[0].testNm);
			}
			//gfnClearDataLoding();
		})
		.catch(function(error) {
			//gfnClearDataLoding();
			console.log(error);
		});
	}
	</script>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h3><i class="bi bi-bullseye"></i> OKR System</h3>
            <p>2024년 4분기</p>
        </div>
        <ul class="sidebar-menu">
            <li>
                <a href="/" class="active">
                    <i class="bi bi-speedometer2"></i>
                    <span>대시보드</span>
                </a>
            </li>
            <li>
                <a href="/myokr">
                    <i class="bi bi-trophy"></i>
                    <span>나의 OKR</span>
                </a>
            </li>
            <li>
                <a href="/teamokr">
                    <i class="bi bi-people"></i>
                    <span>팀 OKR</span>
                </a>
            </li>
            <li>
                <a href="/companyokr">
                    <i class="bi bi-building"></i>
                    <span>회사 OKR</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="bi bi-graph-up"></i>
                    <span>진행 현황</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="bi bi-clock-history"></i>
                    <span>히스토리</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="bi bi-bar-chart"></i>
                    <span>리포트</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="bi bi-gear"></i>
                    <span>설정</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <div class="top-bar">
            <div>
                <h1>대시보드</h1>
            </div>
            <div class="top-bar-actions">
                <button class="btn-outline-custom">
                    <i class="bi bi-bell"></i> 알림
                </button>
                <div class="user-profile">
                    <div class="user-avatar">김</div>
                    <div>
                        <div style="font-weight: 600; color: #1e293b;">김철수</div>
                        <div style="font-size: 0.75rem; color: #64748b;">개발팀</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card-header">
                    <div>
                        <div class="stat-card-title">총 Objective</div>
                        <div class="stat-card-value">8</div>
                        <div class="stat-card-footer">
                            <span class="trend-up"><i class="bi bi-arrow-up"></i> 2개</span>
                            <span>지난 분기 대비</span>
                        </div>
                    </div>
                    <div class="stat-card-icon primary">
                        <i class="bi bi-trophy"></i>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-card-header">
                    <div>
                        <div class="stat-card-title">전체 진행률</div>
                        <div class="stat-card-value">73%</div>
                        <div class="stat-card-footer">
                            <span class="trend-up"><i class="bi bi-arrow-up"></i> 12%</span>
                            <span>이번 주</span>
                        </div>
                    </div>
                    <div class="stat-card-icon success">
                        <i class="bi bi-graph-up-arrow"></i>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-card-header">
                    <div>
                        <div class="stat-card-title">위험 목표</div>
                        <div class="stat-card-value">2</div>
                        <div class="stat-card-footer">
                            <span class="trend-down"><i class="bi bi-arrow-down"></i> 1개</span>
                            <span>관심 필요</span>
                        </div>
                    </div>
                    <div class="stat-card-icon warning">
                        <i class="bi bi-exclamation-triangle"></i>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-card-header">
                    <div>
                        <div class="stat-card-title">달성 Key Results</div>
                        <div class="stat-card-value">15/24</div>
                        <div class="stat-card-footer">
                            <span class="trend-up"><i class="bi bi-arrow-up"></i> 3개</span>
                            <span>이번 주</span>
                        </div>
                    </div>
                    <div class="stat-card-icon info">
                        <i class="bi bi-check-circle"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts -->
        <div class="chart-container">
            <div class="chart-card">
                <h3><i class="bi bi-pie-chart"></i> 목표 상태 분포</h3>
                <canvas id="statusChart"></canvas>
            </div>
            <div class="chart-card">
                <h3><i class="bi bi-bar-chart-line"></i> 주간 진행률</h3>
                <canvas id="progressChart"></canvas>
            </div>
        </div>

        <!-- OKR List -->
        <div class="okr-section">
            <div class="section-header">
                <h2 class="section-title"><i class="bi bi-list-check"></i> 진행 중인 OKR</h2>
                <button class="btn-primary-custom">
                    <i class="bi bi-plus-lg"></i> 새 OKR 추가
                </button>
            </div>

            <!-- OKR Card 1 -->
            <div class="okr-card">
                <div class="okr-header">
                    <div>
                        <div class="okr-category">개인</div>
                        <h3 class="okr-title">제품 품질 향상을 통한 고객 만족도 증대</h3>
                    </div>
                    <span class="okr-status on-track">정상 진행</span>
                </div>
                <div class="okr-progress">
                    <div class="progress-header">
                        <span>전체 진행률</span>
                        <span style="font-weight: 600; color: var(--primary-color);">85%</span>
                    </div>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill success" style="width: 85%"></div>
                    </div>
                </div>
                <div class="key-results">
                    <div class="key-result-item">
                        <div class="kr-checkbox completed">
                            <i class="bi bi-check"></i>
                        </div>
                        <span class="kr-text">버그 발생률 20% 감소</span>
                        <span class="kr-value">100%</span>
                    </div>
                    <div class="key-result-item">
                        <div class="kr-checkbox completed">
                            <i class="bi bi-check"></i>
                        </div>
                        <span class="kr-text">단위 테스트 커버리지 80% 달성</span>
                        <span class="kr-value">85%</span>
                    </div>
                    <div class="key-result-item">
                        <div class="kr-checkbox">
                        </div>
                        <span class="kr-text">코드 리뷰 완료율 95% 이상 유지</span>
                        <span class="kr-value">70%</span>
                    </div>
                </div>
            </div>

            <!-- OKR Card 2 -->
            <div class="okr-card">
                <div class="okr-header">
                    <div>
                        <div class="okr-category">팀</div>
                        <h3 class="okr-title">개발 생산성 향상 및 배포 주기 단축</h3>
                    </div>
                    <span class="okr-status at-risk">주의 필요</span>
                </div>
                <div class="okr-progress">
                    <div class="progress-header">
                        <span>전체 진행률</span>
                        <span style="font-weight: 600; color: var(--warning-color);">62%</span>
                    </div>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill warning" style="width: 62%"></div>
                    </div>
                </div>
                <div class="key-results">
                    <div class="key-result-item">
                        <div class="kr-checkbox completed">
                            <i class="bi bi-check"></i>
                        </div>
                        <span class="kr-text">CI/CD 파이프라인 구축 완료</span>
                        <span class="kr-value">100%</span>
                    </div>
                    <div class="key-result-item">
                        <div class="kr-checkbox">
                        </div>
                        <span class="kr-text">배포 시간 30분 이내로 단축</span>
                        <span class="kr-value">55%</span>
                    </div>
                    <div class="key-result-item">
                        <div class="kr-checkbox">
                        </div>
                        <span class="kr-text">자동화 테스트 비율 70% 달성</span>
                        <span class="kr-value">32%</span>
                    </div>
                </div>
            </div>

            <!-- OKR Card 3 -->
            <div class="okr-card">
                <div class="okr-header">
                    <div>
                        <div class="okr-category">회사</div>
                        <h3 class="okr-title">신규 기능 출시로 사용자 기반 확대</h3>
                    </div>
                    <span class="okr-status on-track">정상 진행</span>
                </div>
                <div class="okr-progress">
                    <div class="progress-header">
                        <span>전체 진행률</span>
                        <span style="font-weight: 600; color: var(--primary-color);">78%</span>
                    </div>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill" style="width: 78%"></div>
                    </div>
                </div>
                <div class="key-results">
                    <div class="key-result-item">
                        <div class="kr-checkbox completed">
                            <i class="bi bi-check"></i>
                        </div>
                        <span class="kr-text">모바일 앱 베타 버전 출시</span>
                        <span class="kr-value">100%</span>
                    </div>
                    <div class="key-result-item">
                        <div class="kr-checkbox">
                        </div>
                        <span class="kr-text">신규 사용자 10,000명 확보</span>
                        <span class="kr-value">75%</span>
                    </div>
                    <div class="key-result-item">
                        <div class="kr-checkbox">
                        </div>
                        <span class="kr-text">앱 스토어 평점 4.5점 이상 달성</span>
                        <span class="kr-value">60%</span>
                    </div>
                </div>
            </div>

            <!-- OKR Card 4 -->
            <div class="okr-card">
                <div class="okr-header">
                    <div>
                        <div class="okr-category">개인</div>
                        <h3 class="okr-title">기술 역량 강화 및 팀 기여도 증대</h3>
                    </div>
                    <span class="okr-status off-track">지연</span>
                </div>
                <div class="okr-progress">
                    <div class="progress-header">
                        <span>전체 진행률</span>
                        <span style="font-weight: 600; color: var(--danger-color);">45%</span>
                    </div>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill danger" style="width: 45%"></div>
                    </div>
                </div>
                <div class="key-results">
                    <div class="key-result-item">
                        <div class="kr-checkbox">
                        </div>
                        <span class="kr-text">기술 블로그 포스팅 월 2회 이상</span>
                        <span class="kr-value">40%</span>
                    </div>
                    <div class="key-result-item">
                        <div class="kr-checkbox">
                        </div>
                        <span class="kr-text">팀 내 기술 세미나 4회 진행</span>
                        <span class="kr-value">50%</span>
                    </div>
                    <div class="key-result-item">
                        <div class="kr-checkbox">
                        </div>
                        <span class="kr-text">오픈소스 프로젝트 기여 5회 이상</span>
                        <span class="kr-value">40%</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Status Chart
        const statusCtx = document.getElementById('statusChart').getContext('2d');
        new Chart(statusCtx, {
            type: 'doughnut',
            data: {
                labels: ['정상 진행', '주의 필요', '지연'],
                datasets: [{
                    data: [5, 2, 1],
                    backgroundColor: [
                        '#10b981',
                        '#f59e0b',
                        '#ef4444'
                    ],
                    borderWidth: 0,
                    borderRadius: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                cutout: '75%',
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            font: {
                                size: 13,
                                family: "'Inter', sans-serif"
                            },
                            color: '#64748b'
                        }
                    }
                }
            }
        });

        // Progress Chart
        const progressCtx = document.getElementById('progressChart').getContext('2d');
        new Chart(progressCtx, {
            type: 'line',
            data: {
                labels: ['1주차', '2주차', '3주차', '4주차', '5주차', '6주차'],
                datasets: [{
                    label: '진행률 (%)',
                    data: [15, 28, 42, 55, 67, 73],
                    borderColor: '#3b82f6',
                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                    tension: 0.4,
                    fill: true,
                    pointRadius: 6,
                    pointHoverRadius: 8,
                    borderWidth: 3,
                    pointBackgroundColor: '#ffffff',
                    pointBorderWidth: 3
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100,
                        grid: {
                            color: '#f1f5f9',
                            drawBorder: false
                        },
                        ticks: {
                            callback: function(value) {
                                return value + '%';
                            },
                            font: {
                                family: "'Inter', sans-serif",
                                size: 12
                            },
                            color: '#64748b',
                            padding: 8
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            font: {
                                family: "'Inter', sans-serif",
                                size: 12
                            },
                            color: '#64748b',
                            padding: 8
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>