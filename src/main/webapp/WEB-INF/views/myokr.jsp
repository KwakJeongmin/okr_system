<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>나의 OKR - OKR 시스템</title>
    
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
            padding: 20px 24px;
            border-radius: 16px;
            margin-bottom: 24px;
            box-shadow: var(--shadow-sm);
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid var(--border-light);
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
        
        /* Tabs */
        .okr-tabs {
            background: white;
            padding: 8px 24px;
            border-radius: 16px 16px 0 0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            display: flex;
            gap: 12px;
            position: relative;
            border: 1px solid #e2e8f0;
            border-bottom: none;
        }
        
        .tab-item {
            padding: 16px 28px;
            color: #64748b;
            font-weight: 600;
            cursor: pointer;
            border-radius: 10px 10px 0 0;
            transition: all 0.2s ease;
            position: relative;
            background: transparent;
        }
        
        .tab-item:hover {
            color: var(--primary-color);
            background: rgba(59, 130, 246, 0.05);
        }
        
        .tab-item.active {
            color: var(--primary-color);
            background: rgba(59, 130, 246, 0.1);
            font-weight: 700;
        }
        
        .tab-item.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 20%;
            right: 20%;
            height: 3px;
            background: var(--primary-color);
            border-radius: 3px 3px 0 0;
        }
        
        .tab-badge {
            display: inline-block;
            padding: 4px 10px;
            background: #e2e8f0;
            color: #64748b;
            border-radius: 10px;
            font-size: 0.75rem;
            margin-left: 8px;
            font-weight: 700;
            min-width: 24px;
            text-align: center;
        }
        
        .tab-item.active .tab-badge {
            background: var(--primary-color);
            color: white;
        }
        
        /* Content Area */
        .content-area {
            background: white;
            padding: 32px;
            border-radius: 0 16px 16px 16px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            min-height: 400px;
            border: 1px solid #e2e8f0;
            border-top: none;
        }
        
        .tab-content {
            display: none;
        }
        
        .tab-content.active {
            display: block;
        }
        
        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 2px solid #f1f5f9;
        }
        
        /* OKR Item */
        .okr-item {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 20px;
            transition: all 0.3s ease;
            cursor: pointer;
            display: flex;
            gap: 24px;
            position: relative;
            margin-bottom: 16px;
        }
        
        .okr-item:hover {
            border-color: var(--primary-color);
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.1);
        }
        
        .okr-item-progress {
            width: 64px;
            height: 64px;
            flex-shrink: 0;
            position: relative;
            margin-top: 8px;
        }
        
        .okr-item-progress svg {
            transform: rotate(-90deg);
        }
        
        .okr-item-progress .progress-text {
            font-size: 1.125rem;
            font-weight: 700;
        }
        
        .okr-item-content {
            flex: 1;
            min-width: 0;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        
        .okr-item-meta {
            display: flex;
            gap: 8px;
            align-items: center;
            margin-bottom: 4px;
        }
        
        .okr-period {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            color: var(--text-secondary);
            font-size: var(--font-size-sm);
            font-weight: var(--font-weight-medium);
        }
        
        .okr-period i {
            font-size: var(--font-size-sm);
            color: var(--text-tertiary);
        }
        
        .okr-category {
            display: inline-block;
            padding: 2px 8px;
            background: rgba(49, 130, 246, 0.1);
            color: var(--secondary-color);
            border-radius: 4px;
            font-size: var(--font-size-xs);
            font-weight: var(--font-weight-medium);
            letter-spacing: var(--letter-spacing-wide);
        }
        
        .okr-item-title {
            font-size: var(--font-size-lg);
            font-weight: var(--font-weight-semibold);
            color: var(--text-primary);
            margin: 0;
            line-height: var(--line-height-tight);
            padding-right: 32px;
        }
        
        .okr-item-description {
            color: var(--text-secondary);
            font-size: var(--font-size-base);
            line-height: var(--line-height-relaxed);
            margin: 0;
            margin-top: 4px;
        }
        
        .okr-item-summary {
            display: flex;
            align-items: center;
            gap: 16px;
            color: var(--text-secondary);
            font-size: var(--font-size-sm);
            margin-top: 12px;
        }
        
        .okr-item-summary span {
            display: flex;
            align-items: center;
            gap: 4px;
        }
        
        .okr-item-summary i {
            font-size: var(--font-size-base);
            color: var(--secondary-color);
        }
        
        .okr-item-header {
            display: flex;
            flex-direction: column;
            margin-bottom: 16px;
        }
        
        .okr-item-left {
            flex: 1;
        }
        
        .okr-top-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        
        .okr-item-meta {
            display: flex;
            gap: 8px;
            align-items: center;
            margin-bottom: 14px;
        }
        
        .okr-period {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 5px 10px;
            background: transparent;
            color: #64748b;
            border-radius: 6px;
            font-size: 0.8125rem;
            font-weight: 500;
        }
        
        .okr-period i {
            font-size: 0.875rem;
            opacity: 0.7;
        }
        
        .okr-category {
            display: inline-block;
            padding: 5px 12px;
            background: var(--primary-color);
            color: white;
            border-radius: 6px;
            font-size: 0.6875rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }
        
        .okr-item-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #0f172a;
            margin: 0 0 8px 0;
            line-height: 1.5;
        }
        
        .okr-item-description {
            color: #64748b;
            line-height: 1.6;
            margin-bottom: 16px;
            font-size: 0.875rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .okr-item-right {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
        }
        
        .progress-circle {
            width: 64px;
            height: 64px;
            position: relative;
        }
        
        .progress-circle svg {
            transform: rotate(-90deg);
        }
        
        .progress-circle-bg {
            fill: none;
            stroke: #e2e8f0;
            stroke-width: 6;
        }
        
        .progress-circle-fill {
            fill: none;
            stroke: var(--primary-color);
            stroke-width: 6;
            stroke-linecap: round;
            transition: stroke-dashoffset 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .progress-circle-fill.success {
            stroke: var(--success-color);
        }
        
        .progress-circle-fill.warning {
            stroke: var(--warning-color);
        }
        
        .progress-circle-fill.danger {
            stroke: var(--danger-color);
        }
        
        .progress-text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 1.125rem;
            font-weight: 800;
            color: var(--text-primary);
        }
        
        .okr-status-badge {
            padding: 6px 10px;
            border-radius: 8px;
            font-size: var(--font-size-xs);
            font-weight: var(--font-weight-medium);
            white-space: nowrap;
            letter-spacing: var(--letter-spacing-wide);
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }
        
        .okr-status-badge i {
            font-size: var(--font-size-xs);
        }
        
        .okr-status-badge.on-track {
            background: rgba(0, 192, 115, 0.1);
            color: var(--success-color);
        }
        
        .okr-status-badge.at-risk {
            background: rgba(255, 179, 0, 0.1);
            color: var(--warning-color);
        }
        
        .okr-status-badge.off-track {
            background: rgba(243, 77, 77, 0.1);
            color: var(--danger-color);
        }
        
        .okr-status-badge.completed {
            background: rgba(49, 130, 246, 0.1);
            color: var(--secondary-color);
        }
        
        /* Key Results Summary */
        .kr-summary {
            display: flex;
            gap: 24px;
            padding: 0;
            background: transparent;
            border-radius: 0;
            margin-bottom: 18px;
            border: none;
            padding-bottom: 16px;
            border-bottom: 1px solid #f1f5f9;
        }
        
        .kr-summary-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .kr-summary-item i {
            font-size: 1rem;
            color: var(--primary-color);
        }
        
        .kr-summary-item .label {
            font-size: 0.8125rem;
            color: #64748b;
            font-weight: 500;
        }
        
        .kr-summary-item .value {
            font-size: 0.9375rem;
            font-weight: 700;
            color: #0f172a;
            margin-left: 2px;
        }
        
        /* Key Results List */
        .key-results-list {
            margin-top: 16px;
            flex: 1;
        }
        
        .kr-item {
            display: flex;
            align-items: start;
            gap: 12px;
            padding: 12px 0;
            margin-bottom: 0;
            border-bottom: 1px solid #f8fafc;
        }
        
        .kr-item:last-child {
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
        
        .kr-item-content {
            flex: 1;
        }
        
        .kr-item-title {
            font-weight: 500;
            color: #0f172a;
            margin-bottom: 6px;
            font-size: 0.9375rem;
            line-height: 1.4;
        }
        
        .kr-item-progress {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .kr-progress-bar {
            flex: 1;
            height: 6px;
            background: #f1f5f9;
            border-radius: 10px;
            overflow: hidden;
        }
        
        .kr-progress-fill {
            height: 100%;
            background: var(--primary-color);
            border-radius: 10px;
            transition: width 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .kr-progress-fill.completed {
            background: var(--success-color);
        }
        
        .kr-progress-value {
            font-size: 0.8125rem;
            font-weight: 600;
            color: var(--primary-color);
            min-width: 40px;
            text-align: right;
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
            margin-top: auto;
            padding-top: 16px;
            border-top: 1px solid #f1f5f9;
            flex-wrap: wrap;
            justify-content: flex-end;
        }
        
        .btn-action {
            padding: 8px 12px;
            border: none;
            border-radius: 6px;
            font-weight: 500;
            font-size: 0.8125rem;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: transparent;
            color: #64748b;
        }
        
        .btn-action:hover {
            background: #f8fafc;
        }
        
        .btn-action.primary {
            color: var(--primary-color);
        }
        
        .btn-action.primary:hover {
            background: rgba(59, 130, 246, 0.1);
        }
        
        .btn-action.danger {
            color: #ef4444;
        }
        
        .btn-action.danger:hover {
            background: rgba(239, 68, 68, 0.1);
        }
        
        .btn-action i {
            font-size: 0.9375rem;
        }
        
        /* Primary Buttons */
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
            background: var(--bg-primary);
            color: var(--text-primary);
            border: 1px solid var(--border-medium);
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: var(--font-weight-medium);
            font-size: var(--font-size-base);
            transition: all var(--transition-fast);
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-outline-custom:hover {
            background: var(--hover-light);
            border-color: var(--border-medium);
            color: var(--text-primary);
        }
        
        .btn-outline-custom:active {
            background: var(--hover-medium);
        }
        
        /* Empty State */
        .empty-state {
            grid-column: 1 / -1;
            text-align: center;
            padding: 60px 20px;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #cbd5e1;
            margin-bottom: 20px;
        }
        
        .empty-state h3 {
            color: #475569;
            margin-bottom: 12px;
        }
        
        .empty-state p {
            color: #94a3b8;
            margin-bottom: 24px;
        }
        
        /* Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            backdrop-filter: blur(4px);
        }
        
        .modal.show {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .modal-content {
            background: white;
            padding: 32px;
            border-radius: 16px;
            width: 90%;
            max-width: 800px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 24px;
        }
        
        .modal-header h2 {
            margin: 8px 0 0 0;
            color: #0f172a;
            font-size: 1.5rem;
            font-weight: 600;
        }
        
        .modal-meta {
            display: flex;
            gap: 12px;
            align-items: center;
            margin-bottom: 12px;
        }
        
        .close-btn {
            background: none;
            border: none;
            font-size: 1.25rem;
            color: #64748b;
            cursor: pointer;
            padding: 8px;
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        
        .close-btn:hover {
            background: #f1f5f9;
            color: #1e293b;
        }
        
        .modal-body {
            margin-bottom: 24px;
        }
        
        .modal-description {
            color: #475569;
            line-height: 1.6;
            font-size: 0.9375rem;
            margin-bottom: 24px;
        }
        
        .modal-progress {
            display: flex;
            gap: 32px;
            align-items: center;
            margin-bottom: 32px;
            padding: 24px;
            background: #f8fafc;
            border-radius: 12px;
        }
        
        .progress-circle.large {
            width: 120px;
            height: 120px;
        }
        
        .progress-circle.large .progress-text {
            font-size: 1.5rem;
        }
        
        .progress-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-label {
            color: #64748b;
            font-size: 0.875rem;
            margin-bottom: 4px;
        }
        
        .stat-value {
            color: #0f172a;
            font-size: 1.25rem;
            font-weight: 600;
        }
        
        .modal-section {
            margin-bottom: 24px;
        }
        
        .modal-section h3 {
            color: #0f172a;
            font-size: 1.125rem;
            font-weight: 600;
            margin: 0 0 16px 0;
        }
        
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            padding-top: 24px;
            border-top: 1px solid #f1f5f9;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            font-weight: 600;
            color: #475569;
            margin-bottom: 8px;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }
        
        textarea.form-control {
            resize: vertical;
            min-height: 100px;
        }
        
        .modal-footer {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
            margin-top: 24px;
            padding-top: 24px;
            border-top: 2px solid #f1f5f9;
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
                <a href="/myokr" class="active">
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
                <h1><i class="bi bi-trophy"></i> 나의 OKR</h1>
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
                    <option value="completed">완료</option>
                </select>
            </div>
            
            <div class="filter-item">
                <label>정렬</label>
                <select class="filter-select" id="sortFilter">
                    <option value="recent">최근 수정순</option>
                    <option value="progress">진행률순</option>
                    <option value="name">이름순</option>
                </select>
            </div>
            
            <div class="search-box">
                <input type="text" placeholder="OKR 검색..." id="searchInput">
                <i class="bi bi-search"></i>
            </div>
            
            <button class="btn-primary-custom" onclick="openAddOkrModal()">
                <i class="bi bi-plus-lg"></i> 새 OKR 추가
            </button>
        </div>

        <!-- Tabs -->
        <div class="okr-tabs">
            <div class="tab-item active" data-tab="active">
                진행 중 <span class="tab-badge">4</span>
            </div>
            <div class="tab-item" data-tab="completed">
                완료 <span class="tab-badge">2</span>
            </div>
            <div class="tab-item" data-tab="draft">
                임시저장 <span class="tab-badge">1</span>
            </div>
        </div>

        <!-- Content Area -->
        <div class="content-area">
            <div id="activeContent" class="tab-content active">
                <!-- OKR Item 1 -->
                <div class="okr-item" onclick="openOkrModal(1)">
                    <div class="okr-item-progress">
                        <svg width="64" height="64">
                            <circle class="progress-circle-bg" cx="32" cy="32" r="28"></circle>
                            <circle class="progress-circle-fill success" cx="32" cy="32" r="28"
                                stroke-dasharray="175.9" stroke-dashoffset="26.4"></circle>
                        </svg>
                        <div class="progress-text">85%</div>
                    </div>
                    
                    <div class="okr-item-content">
                        <div class="okr-item-meta">
                            <span class="okr-period">
                                <i class="bi bi-calendar3"></i>
                                2024 Q4
                            </span>
                            <span class="okr-category">개인</span>
                            <span class="okr-status-badge on-track">정상 진행</span>
                        </div>
                        <h3 class="okr-item-title">제품 품질 향상을 통한 고객 만족도 증대</h3>
                        <p class="okr-item-description">
                            코드 품질 개선과 테스트 커버리지 확대를 통해 버그를 줄이고 안정적인 제품을 제공하여 고객 만족도를 높입니다.
                        </p>
                        <div class="okr-item-summary">
                            <span><i class="bi bi-check-circle-fill"></i> 2/3 완료</span>
                            <span><i class="bi bi-calendar-check"></i> 45일 남음</span>
                        </div>
                    </div>
                </div>

                <!-- OKR Item 2 -->
                <div class="okr-item" onclick="openOkrModal(2)">
                    <div class="okr-item-progress">
                        <svg width="64" height="64">
                            <circle class="progress-circle-bg" cx="32" cy="32" r="28"></circle>
                            <circle class="progress-circle-fill danger" cx="32" cy="32" r="28"
                                stroke-dasharray="175.9" stroke-dashoffset="96.7"></circle>
                        </svg>
                        <div class="progress-text">45%</div>
                    </div>
                    
                    <div class="okr-item-content">
                        <div class="okr-item-meta">
                            <span class="okr-period">
                                <i class="bi bi-calendar3"></i>
                                2024 Q4
                            </span>
                            <span class="okr-category">개인</span>
                            <span class="okr-status-badge off-track">지연</span>
                        </div>
                        <h3 class="okr-item-title">기술 역량 강화 및 팀 기여도 증대</h3>
                        <p class="okr-item-description">
                            지속적인 학습과 지식 공유를 통해 개인의 기술 역량을 강화하고 팀 전체의 기술 수준을 향상시킵니다.
                        </p>
                        <div class="okr-item-summary">
                            <span><i class="bi bi-check-circle-fill"></i> 0/3 완료</span>
                            <span><i class="bi bi-calendar-check"></i> 45일 남음</span>
                        </div>
                    </div>
                </div>

                <!-- OKR Item 3 -->
                <div class="okr-item" onclick="openOkrModal(3)">
                    <div class="okr-item-progress">
                        <svg width="64" height="64">
                            <circle class="progress-circle-bg" cx="32" cy="32" r="28"></circle>
                            <circle class="progress-circle-fill warning" cx="32" cy="32" r="28"
                                stroke-dasharray="175.9" stroke-dashoffset="66.8"></circle>
                        </svg>
                        <div class="progress-text">62%</div>
                    </div>
                    
                    <div class="okr-item-content">
                        <div class="okr-item-meta">
                            <span class="okr-period">
                                <i class="bi bi-calendar3"></i>
                                2024 Q4
                            </span>
                            <span class="okr-category">개인</span>
                            <span class="okr-status-badge at-risk">주의 필요</span>
                        </div>
                        <h3 class="okr-item-title">개발 생산성 향상 및 효율적인 워크플로우 구축</h3>
                        <p class="okr-item-description">
                            자동화 도구 도입과 프로세스 개선을 통해 개발 생산성을 높이고 반복 작업을 줄입니다.
                        </p>
                        <div class="okr-item-summary">
                            <span><i class="bi bi-check-circle-fill"></i> 1/3 완료</span>
                            <span><i class="bi bi-calendar-check"></i> 45일 남음</span>
                        </div>
                    </div>
                </div>

                <!-- OKR Item 4 -->
                <div class="okr-item" onclick="openOkrModal(4)">
                    <div class="okr-item-progress">
                        <svg width="64" height="64">
                            <circle class="progress-circle-bg" cx="32" cy="32" r="28"></circle>
                            <circle class="progress-circle-fill success" cx="32" cy="32" r="28"
                                stroke-dasharray="175.9" stroke-dashoffset="17.6"></circle>
                        </svg>
                        <div class="progress-text">90%</div>
                    </div>
                    
                    <div class="okr-item-content">
                        <div class="okr-item-meta">
                            <span class="okr-period">
                                <i class="bi bi-calendar3"></i>
                                2024 Q4
                            </span>
                            <span class="okr-category">개인</span>
                            <span class="okr-status-badge on-track">정상 진행</span>
                        </div>
                        <h3 class="okr-item-title">사용자 경험 개선 및 고객 피드백 반영</h3>
                        <p class="okr-item-description">
                            사용자 피드백을 적극 수렴하고 데이터 분석을 통해 UI/UX를 개선하여 사용자 만족도를 높입니다.
                        </p>
                        <div class="okr-item-summary">
                            <span><i class="bi bi-check-circle-fill"></i> 2/3 완료</span>
                            <span><i class="bi bi-calendar-check"></i> 45일 남음</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div id="completedContent" class="tab-content">
                <div class="empty-state">
                    <i class="bi bi-trophy"></i>
                    <h3>완료된 OKR이 없습니다</h3>
                    <p>완료된 OKR이 여기에 표시됩니다.</p>
                </div>
            </div>
            
            <div id="draftContent" class="tab-content">
                <div class="empty-state">
                    <i class="bi bi-file-earmark-text"></i>
                    <h3>임시저장된 OKR이 없습니다</h3>
                    <p>작성 중인 OKR을 임시저장하면 여기에 표시됩니다.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- OKR Detail Modal -->
    <div id="okrDetailModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <div>
                    <div class="modal-meta">
                        <span class="okr-period">
                            <i class="bi bi-calendar3"></i>
                            2024 Q4
                        </span>
                        <span class="okr-category">개인</span>
                        <span class="okr-status-badge on-track">정상 진행</span>
                    </div>
                    <h2>제품 품질 향상을 통한 고객 만족도 증대</h2>
                </div>
                <button class="close-btn" onclick="closeOkrModal()">
                    <i class="bi bi-x-lg"></i>
                </button>
            </div>
            
            <div class="modal-body">
                <div class="modal-description">
                    코드 품질 개선과 테스트 커버리지 확대를 통해 버그를 줄이고 안정적인 제품을 제공하여 고객 만족도를 높입니다.
                </div>
                
                <div class="modal-progress">
                    <div class="progress-circle large">
                        <svg width="120" height="120">
                            <circle class="progress-circle-bg" cx="60" cy="60" r="54"></circle>
                            <circle class="progress-circle-fill success" cx="60" cy="60" r="54"
                                stroke-dasharray="339.3" stroke-dashoffset="50.9"></circle>
                        </svg>
                        <div class="progress-text">85%</div>
                    </div>
                    
                    <div class="progress-stats">
                        <div class="stat-item">
                            <div class="stat-label">완료된 KR</div>
                            <div class="stat-value">2/3</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-label">진행 중</div>
                            <div class="stat-value">1</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-label">남은 기간</div>
                            <div class="stat-value">45일</div>
                        </div>
                    </div>
                </div>
                
                <div class="modal-section">
                    <h3>Key Results</h3>
                    <div class="key-results-list">
                        <div class="kr-item">
                            <div class="kr-checkbox completed">
                                <i class="bi bi-check-lg"></i>
                            </div>
                            <div class="kr-item-content">
                                <div class="kr-item-title">버그 발생률 20% 감소</div>
                                <div class="kr-item-progress">
                                    <div class="kr-progress-bar">
                                        <div class="kr-progress-fill completed" style="width: 100%;"></div>
                                    </div>
                                    <span class="kr-progress-value">100%</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="kr-item">
                            <div class="kr-checkbox completed">
                                <i class="bi bi-check-lg"></i>
                            </div>
                            <div class="kr-item-content">
                                <div class="kr-item-title">단위 테스트 커버리지 80% 달성</div>
                                <div class="kr-item-progress">
                                    <div class="kr-progress-bar">
                                        <div class="kr-progress-fill completed" style="width: 85%;"></div>
                                    </div>
                                    <span class="kr-progress-value">85%</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="kr-item">
                            <div class="kr-checkbox">
                            </div>
                            <div class="kr-item-content">
                                <div class="kr-item-title">코드 리뷰 완료율 95% 이상 유지</div>
                                <div class="kr-item-progress">
                                    <div class="kr-progress-bar">
                                        <div class="kr-progress-fill" style="width: 70%;"></div>
                                    </div>
                                    <span class="kr-progress-value">70%</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
                <button class="btn-action danger">
                    <i class="bi bi-trash"></i> 삭제
                </button>
                <button class="btn-action secondary">
                    <i class="bi bi-graph-up"></i> 진행률 업데이트
                </button>
                <button class="btn-action primary">
                    <i class="bi bi-pencil"></i> 수정
                </button>
            </div>
        </div>
    </div>

    <!-- Add OKR Modal -->
    <div id="addOkrModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2><i class="bi bi-plus-circle"></i> 새 OKR 추가</h2>
                <button class="close-btn" onclick="closeAddOkrModal()">
                    <i class="bi bi-x-lg"></i>
                </button>
            </div>
            
            <form id="okrForm">
                <div class="form-group">
                    <label for="okrPeriod">기간 *</label>
                    <select class="form-control" id="okrPeriod" required>
                        <option value="">선택하세요</option>
                        <option value="2024-q4" selected>2024년 4분기</option>
                        <option value="2024-q3">2024년 3분기</option>
                        <option value="2025-q1">2025년 1분기</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="okrCategory">카테고리 *</label>
                    <select class="form-control" id="okrCategory" required>
                        <option value="">선택하세요</option>
                        <option value="personal">개인</option>
                        <option value="team">팀</option>
                        <option value="company">회사</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="okrTitle">Objective (목표) *</label>
                    <input type="text" class="form-control" id="okrTitle" 
                           placeholder="예: 제품 품질 향상을 통한 고객 만족도 증대" required>
                </div>
                
                <div class="form-group">
                    <label for="okrDescription">설명</label>
                    <textarea class="form-control" id="okrDescription" 
                              placeholder="목표에 대한 상세 설명을 입력하세요"></textarea>
                </div>
                
                <div class="form-group">
                    <label>Key Results (핵심 결과) *</label>
                    <div id="keyResultsList">
                        <input type="text" class="form-control" style="margin-bottom: 10px;" 
                               placeholder="Key Result 1" required>
                        <input type="text" class="form-control" style="margin-bottom: 10px;" 
                               placeholder="Key Result 2" required>
                        <input type="text" class="form-control" style="margin-bottom: 10px;" 
                               placeholder="Key Result 3" required>
                    </div>
                    <button type="button" class="btn-action secondary" style="margin-top: 10px;">
                        <i class="bi bi-plus-lg"></i> Key Result 추가
                    </button>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn-action secondary" onclick="closeAddOkrModal()">
                        취소
                    </button>
                    <button type="button" class="btn-action secondary">
                        <i class="bi bi-file-earmark"></i> 임시저장
                    </button>
                    <button type="submit" class="btn-action primary">
                        <i class="bi bi-check-lg"></i> 저장
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Tab switching
        document.querySelectorAll('.tab-item').forEach(tab => {
            tab.addEventListener('click', function() {
                // Remove active class from all tabs
                document.querySelectorAll('.tab-item').forEach(t => t.classList.remove('active'));
                
                // Add active class to clicked tab
                this.classList.add('active');
                
                // Hide all tab contents
                document.querySelectorAll('.tab-content').forEach(content => {
                    content.classList.remove('active');
                });
                
                // Show selected tab content
                const tabType = this.getAttribute('data-tab');
                const contentId = tabType + 'Content';
                document.getElementById(contentId).classList.add('active');
            });
        });
        
        // OKR Detail Modal functions
        function openOkrModal(id) {
            document.getElementById('okrDetailModal').classList.add('show');
            // TODO: Load OKR data based on id
        }
        
        function closeOkrModal() {
            document.getElementById('okrDetailModal').classList.remove('show');
        }
        
        // Add OKR Modal functions
        function openAddOkrModal() {
            document.getElementById('addOkrModal').classList.add('show');
        }
        
        function closeAddOkrModal() {
            document.getElementById('addOkrModal').classList.remove('show');
        }
        
        // Close modals when clicking outside
        window.onclick = function(event) {
            const addModal = document.getElementById('addOkrModal');
            const detailModal = document.getElementById('okrDetailModal');
            
            if (event.target === addModal) {
                closeAddOkrModal();
            } else if (event.target === detailModal) {
                closeOkrModal();
            }
        }
        
        // Form submission
        document.getElementById('okrForm').addEventListener('submit', function(e) {
            e.preventDefault();
            alert('OKR이 저장되었습니다!');
            closeAddOkrModal();
        });
        
        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            document.querySelectorAll('.okr-item').forEach(item => {
                const title = item.querySelector('.okr-item-title').textContent.toLowerCase();
                
                if (title.includes(searchTerm)) {
                    item.style.display = 'flex';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html>

