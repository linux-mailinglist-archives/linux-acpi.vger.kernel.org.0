Return-Path: <linux-acpi+bounces-12935-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFF5A83C0E
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 10:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F62C3A5B84
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 08:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232401E1DF8;
	Thu, 10 Apr 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G988bKzK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8A5381A3;
	Thu, 10 Apr 2025 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744272216; cv=fail; b=MZYBSx2Wp120echr3RkT/N6vYCRbcSZtfMDxRGp9kFPHTzJbuKWopI6vfbhGKRKvd4Qg0NP+VvL6ypuKe0Rkn5amXZSMAKhcFlkNaw0sWeUtB4+RAEwxCbjo7Yphokl3+VIJDp4B1b8mce0wnYmFwS1lRL/vvdnSztc4HdyM+DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744272216; c=relaxed/simple;
	bh=CYlMrfU2OHWf3HuM7uuKMpr8oB98Tsyo5FgL3o3at0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BKF48bZReaE2J5WrFqilncpIuRhrph1F4TwFFRFeJ+5HBfipVizjvDOfrCkjAO724DraZHxju6wodo/JQQtKvNNVF2UC7SBSEUhQzOd087QOkixrlTegUax8nGDyCEFW8xgNjvlAZha3h2d3id7aY/4A2cWIxkA16P8MWyBHnPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G988bKzK; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDN++Hm/7nZMpmlknAubU93jxZapFwvxj/SWFvgc9q5GrfWgGLAeK2hz4nR6S3LpTApN8VNNXJpYCdCepedQRNE/Kk25fxiHE2aEsV5V+0F8X2n9BZrb4U3soYksWPJcweCtsY3nTqu+mliZOKrMrzFzHNy5ENbnbWnOIfVP0SwL9etepj0yFw5CkeHPV7SV2Bx7ntoFma3vibbsgcw3gvFRnVs0IzUEQCgfuh/nil3V/JoFYlWWd8c/FMDX3nSo5xsrIEdiS5Kl8+36mL7xWyGGSC2CHn/TzmpTcThoZqeqx1WLPphn+21huUodFwHyII0SciAmMiDjes6uvtAbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpkxWLReosHUgqQ4gKzh4PLA2Ap6tAVbNvAZBN2SLSM=;
 b=EIHUNJKq4KgjFZri0uOs1MGTLN+AAXeQFAI0Nuagva/sQXLPtaUFpt1mYxYnHMBQ2Xdnz9ynv5RHnmieaCtvfhxsStd1gjc6b1Q/ffofS4pLBz5hWrwUuLtcoCfOhMOWUBV4Bc98VyZ5gmRQtkfq6p4KBpdvCeTNhKZBcF8rbYePyqw+te/fT8X9MnKpT7WgKRA81vh4U/Guyl8B5YBENFIowC4n1VXM7xiAkd2BFfFGaIsb5qVmfBuo0MssHNNbzaRJcHKORFs33dLetRQnEwHi+JsaDsRK8xBB4ytTJSnPXIFj51ULj7w2NhlmqkB2HDflSkvYn+g2yoTgysQQGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpkxWLReosHUgqQ4gKzh4PLA2Ap6tAVbNvAZBN2SLSM=;
 b=G988bKzKFQYhhdogkKP6EOAKuAEEfZuurBZqaIMoAkZrCsUpsxZqoPo/SjmTpr3uGJlIF/x3ff91FeM6f5NMu8pamWoE4ALUq3XX8rT0SG7RiUviIsXq47oVmvyB8vC5VSWgD6n9blhMTUTRNcOqfMxIS7hF4JZR7bBDBBgSqtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 08:03:31 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%3]) with mapi id 15.20.8632.024; Thu, 10 Apr 2025
 08:03:31 +0000
Message-ID: <344adc8a-6a35-4093-98c1-73f1e6de4eb5@amd.com>
Date: Thu, 10 Apr 2025 13:33:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: amd: Fix use of undeclared identifier
 'pinctrl_amd_s2idle_dev_ops'
To: Mario Limonciello <superm1@kernel.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 kernel test robot <lkp@intel.com>
References: <20250409213521.2218692-1-superm1@kernel.org>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20250409213521.2218692-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::27) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5c8c25-7794-4d26-ccc7-08dd78062f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWhIMzRXdHJaT090UTZpemJIQnkzUnFEZVVTU2RDL2VadTZHcnpDZVVjdXEv?=
 =?utf-8?B?eTUzNExHYk5jdjVSOVRZRzhydFNFNHZEOWJES1ZKQ0dDZmIwZVkwNkxBNVYv?=
 =?utf-8?B?aWV5dnA0TUxYT0RSem9OSTlWNDhvZ1cwTW5xS3QyU2ZLdnlNREVIQlBaeEFR?=
 =?utf-8?B?SDdCZ2hPN2YzbUJVY1pDZElzdjcvVWlJalZMQTJSd0c3ODkxUXJZRlkzam9o?=
 =?utf-8?B?dGJtYTY2cDh3eXpoSk5yODRLNTVjVS9DbDZ3dWtMdEloYUZWOG85cll1Rm9n?=
 =?utf-8?B?V1MwMm40bG9JWUdIS3ZvRC9FWXV1WmJYL3hnSFpQcllHN3E2SWtzMW1nNWcw?=
 =?utf-8?B?SDVqVGQxRnpOK1lvMnVZdTFic2U0Mk8rMnU5YnZBbTNnTkxmZUlKOWpFblJ2?=
 =?utf-8?B?aWF3WGhRYXZSQTdCZlhWQWRXN0hBWHhzTmxaVURsTCt3Y1BwUlFmdEtQcGFv?=
 =?utf-8?B?MFZxYkJaQlBXNGF2VVBlOVZOeUhpQSt3c0lwbTU0QXErQVZsYU9hRy9TZGhD?=
 =?utf-8?B?ZEltRGhRYjAwdVd3VUtWK2k4VTh3cXl6L1hPaEdnRSt2SFBIMGgwcVNXZzhD?=
 =?utf-8?B?MS9tbjlUVVZYbVZxV1FGL01OYjNRTDRETzgvbUh6QVBPd0pNR3JVc2NZM1gy?=
 =?utf-8?B?UVlrdENpODBRdisyZjBKOWZsTkxKU2ROOXBOKzE1V1JqQi9UWlNyeGVnc1Rs?=
 =?utf-8?B?NzJtTEtRWXp6VkhvUFZRRC9BRjA4ZXpteVQzQVcvQ2J6Y0ovWmxHNytnYURR?=
 =?utf-8?B?K3h0d0dRNTRyc0tpdzBHdkcxYmFyTlpUWnJoQ1lQZndlcU43d1VXSDdnY1M4?=
 =?utf-8?B?V3NiY2Q2U0pEaGZyamlGdW55cEVCMG1KYkwzN0RXd3hMWHBsQmhPNCtRY3E2?=
 =?utf-8?B?RFZmV0dXb3NrSU91aXdVRi9xbVRyR2pzT2JIc3ZDVUpxMmFrT240L1hEN0dh?=
 =?utf-8?B?RzNUMVdsZFJVa1poaktjR0ZkS1R6ZW5MTWJPUDBFYldFcUF0c05IRzVKMGRQ?=
 =?utf-8?B?Z2NXVURsdG44ZnJCamlyNWRLYkxMMEpMU2Ixb09VVXNaUlExanphdUczSWhz?=
 =?utf-8?B?eTRlZHhlenpCMDdsSTJLYkJ1Y1VNMnJRNFllaVh2UHVzTDU1MGFwNzlmRDRW?=
 =?utf-8?B?MmZ3ZGVpVlMycUJ4ZTM2L2FQZ1RCTSs3dmhJUllIbG1LZDhVdU5wcjI4Tlp5?=
 =?utf-8?B?NUdJbm1CU0lkTENudWt0em9CMkVZSmI1ajJhaEJaYWw1RkRYZ0oydHgwL3BH?=
 =?utf-8?B?WEF4dmlldE5JT3ZWVVNxRFhxNmxoSThFcmllSDFnLzVXaExVenYySEdZcHNY?=
 =?utf-8?B?QW41OCt2YS9RemxBL3p3c2J0OGZDTFRsYXd0OVlPbDYvQytNam5EcXJDTVh6?=
 =?utf-8?B?aTlpY3IzVnZ1NnZkQjNYeWdzMCtXWXJnTzJFc2hVbWNQSHJXajFpVjl6ckFN?=
 =?utf-8?B?eWJkVkt0cG84bkRXSVRnSnZ5YytBL1NENnlOcHlGU0Z1SDJ5eWxmQngwSWFX?=
 =?utf-8?B?SlphVHhkZnJqaFU4ZG8wT1ZNNFBpQmpJSGJYSEdWMGdRZ3RiTG54Z0xFU3g2?=
 =?utf-8?B?OFB3eEo4TGJjT09kMkZrOEJ1S0pFU0d1MkwvenVCamFGd05GVTJVUEI2Qnlr?=
 =?utf-8?B?SS9FcURFc1U1N25UMzY0UzNXTWU4cEFIbXBnYnRiT3BqVEJxK0N4WUpEdk9q?=
 =?utf-8?B?YzdxVHM5VXJUZVk3OUxOZ3NrL3hIL1hYbEEySjFiaUZyeDlTdDBkVTl0M0gw?=
 =?utf-8?B?dGNzQ0lVeTludFd5dGk2K2luNTlsNGJBS2E2dWJNR0N6TS81K2dZQmR6ZWp0?=
 =?utf-8?B?aGgrL1JjRHE5VFZjNjg3eklTcGhTU25WV0srNGxKOG1aSk45NWl0YmVETjEy?=
 =?utf-8?B?TEdUbDFkWEtTaUZBUHJoZW9sa2V2dUxKd1hDaEY3eGhFNXFZNzBtZmJyL0k2?=
 =?utf-8?Q?AO0Zt+mxrxc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHJieENTS3pnd1FST21NTXNPN2lGL1hWdmJaT2IremVEam5oT21Kc3krbGg5?=
 =?utf-8?B?WWVJd1p0dzF5RXc4OEdDd1NET3Y4amZRLzVQMHI5ckNjd3hBSEkrMkJBWDJY?=
 =?utf-8?B?UGFucmFnWE9LUksrY3NiYmlLSTh2WTlqVk4zczBxQTBiK2lJTGsrS2NVTXda?=
 =?utf-8?B?SG1pZkd5alppbC8zT3ZaMzF4NW45TW9LNGg1SzJmOXBjbWFzOVlNRk9JN0o1?=
 =?utf-8?B?bzR0ME8xWXhadG9nN1l1TGVGK0FDSmxRNDEzWjJMRktXZVB1OThFZzhMdlBM?=
 =?utf-8?B?NFhpRnFjb2ZlbnJSRGlnZEx2anZ1RjFSeXBpd2FaMG9TYzc1YllZSHQwMjgz?=
 =?utf-8?B?bk52UGZyRXVrUmdRN05tYVBnUm42cE9md2tPeExZTjJFWmN1Z0UzWnJsbFNH?=
 =?utf-8?B?YkNaZVZjUXk3WW4vN05sQnFCTEsxRGpYUmU0S0xCeHJxb1hWNjB5K3U0OGMr?=
 =?utf-8?B?MmQ2Mnp6VFg2bmFxcitqYU5ISzZwR0JyYzZnTlNMRVR2c3VuL0JnMVY0NVh2?=
 =?utf-8?B?a1NCYVFZWXdCbnFSaEZmY1dqMjUrcnVJY1RWbXYrK2JjbEdYa1NCQ2c5ZHdI?=
 =?utf-8?B?dUNPYmpHRzVKczFBV0RJWDR6a0Uvc3pwWkxWZ0tyZ3ZXaTgxOUZWRUhDZ1do?=
 =?utf-8?B?bWhYa1BwOTRRRGcvdnRxWUVHcmRsZFJOV05hNFRlUmVuTStNWThrZWZkazh3?=
 =?utf-8?B?dzFGOVp0M21FQnpPWUVHN3lpVkRGc0hqOUt1d3NORnVPdkEyYkpzSmdCNWpj?=
 =?utf-8?B?VkVxMzNWTjh1ZlRpNmQvaVp1Q1VleGRKdThBUE1BL09GVG43dUJhNW40V211?=
 =?utf-8?B?Q1I2bXE5U2VzbEdSVjdTemY0SEJwRnpIZWdseW9oc2J5YjFQZm0xV1hjekx0?=
 =?utf-8?B?VTdWdFhlOWViR205dU1jZlZXaDdCdG8yVnBOZVJpajJydXJDWjhnZVZuYnZu?=
 =?utf-8?B?TGt6ZWI2enJNRHBwa3dXZy80N05uT3JPMWprQnRlYjZwQUV2cGtSOGVvUDZX?=
 =?utf-8?B?TElsNEQrdU9pZHVNTHhOdlhTNkozQ0NrcWhhZmgvSFdIZmdWRXpLZUxuTjE5?=
 =?utf-8?B?V2pQZk9FT21wRXhjQ2tpakpVaGtxQzV3Q0NFUzR4NUwxQTJESlVKZStGOHpa?=
 =?utf-8?B?NmJRU0FwcjNKZUVGeVlDaDI5WjBmdERBSVBqWWxLTEVvdEhIbmZqNnFuZjlh?=
 =?utf-8?B?Y0NwejJONHBCa3RLYjVRS0V2QzNwQjQ0ZnEzZE9LTHFvb0VSTE50QWZpZHB2?=
 =?utf-8?B?Q0I2MFpmUlA1Z0EzZ04vQ1V5Q3JJZW05VWlpU2pJaXY4SzIvZGpITzAzQWlx?=
 =?utf-8?B?dGpXSkJsL21VMXFSdUs5R21WN2g3TTZTSDlraE9JTkVnVWNEcHVoWFY3bkIw?=
 =?utf-8?B?VitSb1d6RlZoTHVPcWdkSnlGUW1ycGI5bTlUUk40ekxuY255anh6eTdyamdl?=
 =?utf-8?B?UUMrNzRvQWZpcmFWalNGRVFmRzA3alUzc1RGV0c5SCtoR3lzNGV5UmtpTzMr?=
 =?utf-8?B?WUZsWG5GQWZUaUJheVlVQzJGYU9UaHpyRXNkQlROUXFrdXB3MXl5MlVseFFB?=
 =?utf-8?B?TEZ5MWVCUFdFeEZMTTRwYTV3MmFrdGRvNm5oLzlLT2RYSlovM1ZRMzIvMU9P?=
 =?utf-8?B?UUx0RE51SkVlQ1ZKekZiMElJRzBZNHVFdGNRZGN6VmlSQThuTFlxZmgwdERj?=
 =?utf-8?B?UG1qbzJSTFoyVTl2NTAwQTcraDh5YVNLVW9zdk8rUWRvOHFxcUFaaUY2R0cr?=
 =?utf-8?B?enZqYzlHOXJzYnNVNXdOeTlheDV2K2UyVVhVT1FCc1hmNXdaNjVJR2NQbXVl?=
 =?utf-8?B?SHJJbVJsUjBWWEsxenp4QUJZWTVSYytlQnBKRE50T2ZteW5qek5sZmdOZGxo?=
 =?utf-8?B?bDcwOHZSZHNqWS9CbnZzK09rVXpCdXMrWEpRL2RYeFZSYytIVWJJdVJJVlFJ?=
 =?utf-8?B?Wll3RGdvR2xra1dwRjIwNkRwQ2R2WWM2dXA2Q1lOanoxY0d1VTI2QUZZS3Q0?=
 =?utf-8?B?RjE1N04yV1pjMG53RXFVcnJEMXRSbWUxaEEvMEhWOVJOVlBFOWU4dEl1cnU4?=
 =?utf-8?B?V1c1eDQ2Sm1ORUlUM3RmeWM2ajA4UHZtUWZmbzFCaW9JM0VLQ2ZWYVhHYkVo?=
 =?utf-8?Q?25sCvFF9yZookNTV4L/jcnvjr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5c8c25-7794-4d26-ccc7-08dd78062f52
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:03:31.8550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MQAZ8ZjoDOVDPPay1Dyhpex8Pngtest+wcMsS0FFMaMNK+D0eR4uYkP92G8PZTlAdGoCul+pBoo99eWVHn1ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270



On 4/10/2025 03:05, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> `pinctrl_amd_s2idle_dev_ops` is hidden under both `CONFIG_ACPI` and
> `CONFIG_PM_SLEEP` so the functions that use it need the same scope.
> 
> Adjust checks to look for both.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504100420.88UPkUTU-lkp@intel.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Looks good to me.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

