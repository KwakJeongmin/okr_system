<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팀 OKR - OKR 시스템</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');
        
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
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
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
            padding: 40px;
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
            background: #f1f5f9;
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
        
        /* Team Stats */
        .team-stats {
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
        }
        
        .stat-card-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 16px;
        }
        
        .stat-card-title {
            font-size: 0.875rem;
            color: var(--text-secondary);
            margin-bottom: 8px;
        }
        
        .stat-card-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 8px;
        }
        
        .stat-card-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
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
        
        /* Filter Bar */
        .filter-bar {
            background: white;
            padding: 24px;
            border-radius: 16px;
            margin-bottom: 28px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            display: flex;
            gap: 16px;
            flex-wrap: wrap;
            align-items: center;
            border: 1px solid #e2e8f0;
        }
        
        .filter-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .filter-item label {
            font-weight: 600;
            color: #475569;
            margin: 0;
        }
        
        .filter-select {
            padding: 8px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            background: white;
            color: #475569;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 16 16'%3E%3Cpath fill='%23475569' d='M8 10.5l-4-4h8l-4 4z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 8px center;
            padding-right: 32px;
        }
        
        .filter-select:focus {
            outline: none;
            border-color: var(--primary-color);
        }
        
        .search-box {
            flex: 1;
            min-width: 250px;
            position: relative;
        }
        
        .search-box input {
            width: 100%;
            padding: 10px 40px 10px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 0.9375rem;
            transition: all 0.3s ease;
        }
        
        .search-box input:focus {
            outline: none;
            border-color: var(--primary-color);
        }
        
        .search-box i {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
        }
        
        /* Team List */
        .team-list {
            background: white;
            padding: 24px;
            border-radius: 16px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            border: 1px solid #e2e8f0;
        }
        
        .team-list-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 2px solid #f1f5f9;
        }
        
        .team-list-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-primary);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .team-list-title i {
            color: var(--primary-color);
        }
        
        /* Team Card */
        .team-card {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 16px;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .team-card:hover {
            border-color: var(--primary-color);
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.1);
        }
        
        .team-card-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 16px;
        }
        
        .team-info {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        
        .team-avatar {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 1.25rem;
        }
        
        .team-details h3 {
            margin: 0 0 4px 0;
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-primary);
        }
        
        .team-details p {
            margin: 0;
            font-size: 0.875rem;
            color: var(--text-secondary);
        }
        
        .team-status {
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 0.8125rem;
            font-weight: 600;
        }
        
        .team-status.on-track {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }
        
        .team-status.at-risk {
            background: #fed7aa;
            color: #92400e;
            border: 1px solid #fdba74;
        }
        
        .team-status.off-track {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }
        
        .team-progress {
            margin: 16px 0;
        }
        
        .progress-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 0.875rem;
            color: var(--text-secondary);
        }
        
        .progress-bar-container {
            height: 8px;
            background: #f1f5f9;
            border-radius: 10px;
            overflow: hidden;
        }
        
        .progress-bar-fill {
            height: 100%;
            background: var(--primary-color);
            border-radius: 10px;
            transition: width 0.6s ease;
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
        
        .team-members {
            display: flex;
            align-items: center;
            margin-top: 16px;
        }
        
        .member-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.875rem;
            font-weight: 600;
            margin-left: -8px;
            border: 2px solid white;
        }
        
        .member-avatar:first-child {
            margin-left: 0;
        }
        
        .member-count {
            margin-left: 8px;
            font-size: 0.875rem;
            color: var(--text-secondary);
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
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h3><i class="bi bi-bullseye"></i> OKR System</h3>
            <p>2024년 4분기</p>
        </div>
        <ul class="sidebar-menu">
            <li>
                <a href="/">
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
                <a href="/teamokr" class="active">
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
                <h1><i class="bi bi-people"></i> 팀 OKR</h1>
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

        <!-- Team Stats -->
        <div class="team-stats">
            <div class="stat-card">
                <div class="stat-card-header">
                    <div>
                        <div class="stat-card-title">전체 팀</div>
                        <div class="stat-card-value">8</div>
                    </div>
                    <div class="stat-card-icon primary">
                        <i class="bi bi-people"></i>
                    </div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-card-header">
                    <div>
                        <div class="stat-card-title">평균 진행률</div>
                        <div class="stat-card-value">67%</div>
                    </div>
                    <div class="stat-card-icon success">
                        <i class="bi bi-graph-up"></i>
                    </div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-card-header">
                    <div>
                        <div class="stat-card-title">주의 필요</div>
                        <div class="stat-card-value">2</div>
                    </div>
                    <div class="stat-card-icon warning">
                        <i class="bi bi-exclamation-triangle"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filter Bar -->
        <div class="filter-bar">
            <div class="filter-item">
                <label>기간</label>
                <select class="filter-select" id="periodFilter">
                    <option value="all">전체</option>
                    <option value="2024-q4" selected>2024년 4분기</option>
                    <option value="2024-q3">2024년 3분기</option>
                    <option value="2024-q2">2024년 2분기</option>
                    <option value="2024-q1">2024년 1분기</option>
                </select>
            </div>
            
            <div class="filter-item">
                <label>상태</label>
                <select class="filter-select" id="statusFilter">
                    <option value="all">전체</option>
                    <option value="on-track">정상 진행</option>
                    <option value="at-risk">주의 필요</option>
                    <option value="off-track">지연</option>
                </select>
            </div>
            
            <div class="search-box">
                <input type="text" placeholder="팀 검색..." id="searchInput">
                <i class="bi bi-search"></i>
            </div>
            
            <button class="btn-primary-custom">
                <i class="bi bi-plus-lg"></i> 새 팀 OKR 추가
            </button>
        </div>

        <!-- Team List -->
        <div class="team-list">
            <div class="team-list-header">
                <h2 class="team-list-title">
                    <i class="bi bi-people"></i> 전체 팀
                </h2>
            </div>

            <!-- Team Card 1 -->
            <div class="team-card">
                <div class="team-card-header">
                    <div class="team-info">
                        <div class="team-avatar">개발</div>
                        <div class="team-details">
                            <h3>개발팀</h3>
                            <p>프론트엔드 / 백엔드 개발</p>
                        </div>
                    </div>
                    <span class="team-status on-track">정상 진행</span>
                </div>
                
                <div class="team-progress">
                    <div class="progress-header">
                        <span>전체 진행률</span>
                        <span>85%</span>
                    </div>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill success" style="width: 85%"></div>
                    </div>
                </div>
                
                <div class="team-members">
                    <div class="member-avatar">김</div>
                    <div class="member-avatar">이</div>
                    <div class="member-avatar">박</div>
                    <div class="member-avatar">최</div>
                    <span class="member-count">외 2명</span>
                </div>
            </div>

            <!-- Team Card 2 -->
            <div class="team-card">
                <div class="team-card-header">
                    <div class="team-info">
                        <div class="team-avatar">기획</div>
                        <div class="team-details">
                            <h3>기획팀</h3>
                            <p>서비스 기획 / UX</p>
                        </div>
                    </div>
                    <span class="team-status at-risk">주의 필요</span>
                </div>
                
                <div class="team-progress">
                    <div class="progress-header">
                        <span>전체 진행률</span>
                        <span>62%</span>
                    </div>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill warning" style="width: 62%"></div>
                    </div>
                </div>
                
                <div class="team-members">
                    <div class="member-avatar">정</div>
                    <div class="member-avatar">강</div>
                    <div class="member-avatar">조</div>
                    <span class="member-count">외 1명</span>
                </div>
            </div>

            <!-- Team Card 3 -->
            <div class="team-card">
                <div class="team-card-header">
                    <div class="team-info">
                        <div class="team-avatar">디자인</div>
                        <div class="team-details">
                            <h3>디자인팀</h3>
                            <p>UI/UX 디자인</p>
                        </div>
                    </div>
                    <span class="team-status off-track">지연</span>
                </div>
                
                <div class="team-progress">
                    <div class="progress-header">
                        <span>전체 진행률</span>
                        <span>45%</span>
                    </div>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill danger" style="width: 45%"></div>
                    </div>
                </div>
                
                <div class="team-members">
                    <div class="member-avatar">윤</div>
                    <div class="member-avatar">한</div>
                    <div class="member-avatar">임</div>
                    <span class="member-count">외 2명</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            document.querySelectorAll('.team-card').forEach(card => {
                const teamName = card.querySelector('.team-details h3').textContent.toLowerCase();
                const teamDesc = card.querySelector('.team-details p').textContent.toLowerCase();
                
                if (teamName.includes(searchTerm) || teamDesc.includes(searchTerm)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html>
