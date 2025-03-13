Return-Path: <linux-acpi+bounces-12197-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB2BA5F93E
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B2F16E7C2
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5573D268C7E;
	Thu, 13 Mar 2025 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xsightlabs.com header.i=@xsightlabs.com header.b="SVYpPVmJ";
	dkim=pass (1024-bit key) header.d=xsightlabs.com header.i=@xsightlabs.com header.b="SVYpPVmJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2110.outbound.protection.outlook.com [40.107.21.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC47268C58;
	Thu, 13 Mar 2025 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.110
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878505; cv=fail; b=H5lr0zCnWpPJ99+QyH2IwIvNsxiKcNtfD7G5HoEsK774y5gFRtr3SL6vXbRDNMbpRFzWn2LbaURY5DdFnbUJ7+hCj+PW483ImDGGpr6EuR+QA1JyBmZ0p/Ud7qlaWtqU5PrP13DxfiAY1iHXSW+Vf6ioyQv8kYrh0WLa1FCzlU4=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878505; c=relaxed/simple;
	bh=JhUC5djoQ1apDl2k4iyomJX8tmnO3+zWq3tWheN1D1s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CU6CYOgtAHVO7a7+RdFgHjkTJ/xBy/0XtjOQwn48gJmppoltxngAL2wEkVBw5Is2yEUaAZK4wpdwGiyOiKTjUa1iFmR7YhrhuMOi7kNpbLSaY3sqXejO/5ef6oSa/7ivjhtvKw+Z/pqrnzOE3Sr6xqgV4HIFg4X9H4J0U76ZRcc=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xsightlabs.com; spf=pass smtp.mailfrom=xsightlabs.com; dkim=pass (1024-bit key) header.d=xsightlabs.com header.i=@xsightlabs.com header.b=SVYpPVmJ; dkim=pass (1024-bit key) header.d=xsightlabs.com header.i=@xsightlabs.com header.b=SVYpPVmJ; arc=fail smtp.client-ip=40.107.21.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xsightlabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xsightlabs.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oqBa6PMw5kMk+x7au+ZNbggZgwtavx2JnSROkXqlbklMcfszcrtO3K7HF2bpjyPyOT8GizrZhfUjESGjdz5QxkHMvQwLe9Vvpb4vcLdN1mnQ72bkgTgp7ufJI99VmSOwmiccH4oaP+6LuppwYh7+fCX8AIomacW8eQdkXorp6MsJtIHEN+brNe/vBEEgVEgwvSYWe3+qOFEIJ9M5vT0b6ncDqoVLYJAjR5bP+vWNHIJN+65p6jepiSM0R/vx2HiKIiUtWmWv2WFGIFupgWQXPtU0wyQR1wUwp6x4s/4675DABPI9jgO9d3rVNm9vPcNy0FAwAcyh6dHfXB7exRVSfg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTIfsH7b3AfVgLiQ44HtFWmol4EcH8d/vTOC3v3Dq6g=;
 b=mwuDx4ry4+fqmVgmAobVTsLQ2gMkNPZSyvIbQAi6EpXJbobmJKa2iE5NGmwjxVdp6BDZJV83QiVfWrUpTyiSrOU+Q+lmaOeXNB+GhX/LAWdXGtznVGKmywPGBQ2N1GoOmDKMmGVXsXeC2//9HdOaDlALZYR0Yq95rsWRBRvExGfqS3gcYXfu0+87lr1lkdylw7ooBhEG3i2Ec289HcJl0lTySjQ3/m6DSYm1S8BLAoKR7vJ22e5kDBX3+DNP3vgmyQprXQvNCLmolcuLl6up4zPds9z3qjiDtHCdUIt0La4t+iFdfzFIhD77NwDu5OIg9RFAGPL3X/mqEkkPPdC6Og==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=pass (sender ip is
 52.17.62.50) smtp.rcpttodomain=arm.com smtp.mailfrom=xsightlabs.com;
 dmarc=bestguesspass action=none header.from=xsightlabs.com; dkim=pass
 (signature was verified) header.d=xsightlabs.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=xsightlabs.com] dkim=[1,1,header.d=xsightlabs.com]
 dmarc=[1,1,header.from=xsightlabs.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xsightlabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTIfsH7b3AfVgLiQ44HtFWmol4EcH8d/vTOC3v3Dq6g=;
 b=SVYpPVmJUfB/eUrmCuqakeusqZ4xptfEbCJxRzs3VUNlJKIE9mlrw3AguJPnGKDCikzzTF4REshY1kcs83Vg95s+oXQIOoO5yw9Rp4kkF/SBm0Wbt+q41m7vDUcwkSJK2gTOKhe61Ar4drrwsnFzr0+t37iR1kDUp4evYEw6KM0=
Received: from AS4P251CA0014.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::14)
 by AM8P193MB0899.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 15:08:20 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::f2) by AS4P251CA0014.outlook.office365.com
 (2603:10a6:20b:5d2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Thu,
 13 Mar 2025 15:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.17.62.50)
 smtp.mailfrom=xsightlabs.com; dkim=pass (signature was verified)
 header.d=xsightlabs.com;dmarc=bestguesspass action=none
 header.from=xsightlabs.com;
Received-SPF: Pass (protection.outlook.com: domain of xsightlabs.com
 designates 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com; pr=C
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Thu, 13 Mar 2025 15:08:19 +0000
Received: from emails-8549281-6-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-245.eu-west-1.compute.internal [10.20.5.245])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id A322B805D4;
	Thu, 13 Mar 2025 15:08:19 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1741878499; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=lTIfsH7b3AfVgLiQ44HtFWmol4EcH8d/vTOC3v3Dq6g=;
 b=EoviC+Ek6Rwtah1ALnctI+4dIpVd3q++m6ZzIyZPM1V3U9iKgCGr9TitsJgSy8M1+J5eK
 VzAFBF3HzPDPpHy6pYMQLkiSsIBtyUBmOr2E7hXhDh/hykXa6R82JMHxd4tQqX+NGeZBDP1
 7LbkDgWLddhLW4amtl7CKuAH93K2fwc=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1741878499;
 b=pzisk7GCOMCQKkDuf/exyaSQfNHVSyQQdAchnk8tjZ0821PmgihVIKfhcopDevQQDGXZ7
 EcJC3S15yn45/5zNAxjlFKwRLdhbhPDssKdHPrM4k2ca1Izocbc7c14ILvfZRdBUJJx9QU9
 hTW8GGQQpMRMAYfZu6umpSr/R6moTKE=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIU8sa2RwTDAcLg3SZzze6CSQ8vcAzboNhmEpTRfuxrnw2lnBObL9K+BTxxUEo6AHC+wL6BolCYLVD2EsEiLiI6MeK8nud+s+xlUgb/9IcbdPhLIMu4hIXeDLGpish9zWrNJLqUeuugoai/8YHyzxSUgvHbiIAngGqQvRSe4V2b4Gy8lJo6zTdYvvEl2xy7y8VW00houYuYHdSVuSnca11gPAZkhRlQl08Yt7HdkLxWXCiwG3uif5qoLdFOPUGQsm7LrENXIEturxiUmVPjXfMhu7KZi5LY0S3tg9AEruNsn/j9z9ocharW48lhj/4xLqCi8g7V44JOqR3wPXIel4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTIfsH7b3AfVgLiQ44HtFWmol4EcH8d/vTOC3v3Dq6g=;
 b=OwlKzTrlVk9I6rBc/R3XRxgMMSQWZzGoa7eYI0duvldaQuqGYxrK8p9V74aCdtqagLOc2dnI/IgivAv9+42OqUVA9DJv2YfA82pIRIDYrrsOlG+1KbokBGEB0osBKNizZL9Soi8coiYiTtFbL6nRF6fMhHIW8OR7UI9nVsn6Vu8eTau99XHd8RNROhWUnqY/Sh3eZ3nVnDaOYsqb2BF2cFXopfo5T59m52wYda6n8Nd2816YALscjZwv/CPEpYNpaDzCsQ7jYXUoerzM5V8yzFVZ3DCaKX4AR2yi/u6FAIoMppzu0SwEDUCI4jFjEkbthIImUMfr0WJWVt1Hr20Lqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xsightlabs.com; dmarc=pass action=none
 header.from=xsightlabs.com; dkim=pass header.d=xsightlabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xsightlabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTIfsH7b3AfVgLiQ44HtFWmol4EcH8d/vTOC3v3Dq6g=;
 b=SVYpPVmJUfB/eUrmCuqakeusqZ4xptfEbCJxRzs3VUNlJKIE9mlrw3AguJPnGKDCikzzTF4REshY1kcs83Vg95s+oXQIOoO5yw9Rp4kkF/SBm0Wbt+q41m7vDUcwkSJK2gTOKhe61Ar4drrwsnFzr0+t37iR1kDUp4evYEw6KM0=
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:446::5)
 by PAXP193MB2171.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:233::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 15:08:08 +0000
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f2f:5721:1f5:aade]) by AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f2f:5721:1f5:aade%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 15:08:07 +0000
Message-ID: <4ef4df06-c6f8-4151-96e1-78be58f32f54@xsightlabs.com>
Date: Thu, 13 Mar 2025 11:08:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] mailbox: pcc: Always clear the platform ack
 interrupt first
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>,
 Adam Young <admiyo@os.amperecomputing.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-2-1b1822bc8746@arm.com>
Content-Language: en-US
From: Robbie King <robbiek@xsightlabs.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-2-1b1822bc8746@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To AS8P193MB2335.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:446::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8P193MB2335:EE_|PAXP193MB2171:EE_|AM2PEPF0001C70F:EE_|AM8P193MB0899:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aaa6afa-6b20-4477-1f1d-08dd6240e412
X-CLOUD-SEC-AV-Info: xsightlabs,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cjJUSW9aV2ROaU9BckN1ZHRSeUl3cXg3eG5WRHgrRDl6NGtCQlhUdFBjdnpJ?=
 =?utf-8?B?Z3ppSkxlVjh0S3kxRXhpS3E0T1dVQnR2R3ozYnpkMTJPUGFFckZYUGcyN0tE?=
 =?utf-8?B?V3RHY2dXdlFsNmR2Z2FhTjRkSkU0U21SbE96L2JZRXhTemovVkFrUVlsdldN?=
 =?utf-8?B?OUc4RnE5YWVKR3FzSjk2TUkzYXVxQ2tVNSt5enczZXZXd3J4UVNKdU1tcHhD?=
 =?utf-8?B?cjg1TC9oMmd2Z2JXWnVkUmtSNUtkNkhsUUNzVEFRT3Z3SjVkWmNmZWl5QWhy?=
 =?utf-8?B?RlRYdzNuMU1kVU03QUE1STIzTDczMGdETnNzQ2VpRytzYTh3L0FnNHNNQ1dE?=
 =?utf-8?B?UnhVUngwZENGdXViblJsb3p4RS9FOU9pWGgvYWJNcUlLTjFNanp5cHRVQXo1?=
 =?utf-8?B?Z1R0MjMrTTRVeStqVktQc1o2S3BsZ3Z0L2VPV2JzMGlDaWR5R1JRUXgyamtR?=
 =?utf-8?B?VlBmdHM2a0YyWTNDMzRTV1lYYVVyZkZsdW4rM1VtMHJWNGNRaGZXSWZZTFh6?=
 =?utf-8?B?aUR6eElBUE5PUGtlY3RUS0V1U0xLU0V1VEpkT0Q1eEpzT3Z6b244NDdvSVRt?=
 =?utf-8?B?OWRxcnhjQlpDeGNwamRwaDJaYzYvMDZreXFuOHJ3VVlMZ2p4V3VUOWpOajBV?=
 =?utf-8?B?azlJK1lsSGdKNXdRaGhhOHVPaGdOUXVOM2FCRFY5OVo1MTFPVjhQV2VUem1X?=
 =?utf-8?B?NGlpVHF0c0UwbXhMcmZNQW5ybi9CdXdNb2dtVVhOQUpKMEVzS3BXaVQ3K29x?=
 =?utf-8?B?SE5YY0RpT25lNmtUOThhaTdOd1cydk5nYlVQYkNZSjk4TkN4cUhqMytWL2Z2?=
 =?utf-8?B?NCtHVjhkTE5MTG5Uakt5bDh0ZzJOSEZtZUVaaWxlVmNmM01zRG5HYWd4NkRa?=
 =?utf-8?B?amh0VnBkMitySzZBUEdoOTFIY09rdnNaaE4vUGxXUEVRVVVRRFFWdUtkdWlz?=
 =?utf-8?B?S2xuMG83U05oZEg5Nzg2cDB2eE8xVFVjcXBtLzZKOWRaaTlzRWxqbk96bWw1?=
 =?utf-8?B?Mk50cWFGVENhZXRvSU5kNUpHSTUzRHZWZWlhTXg2anAyV3RXRGFwb0h3NmNj?=
 =?utf-8?B?NXNFS3RzaXNYK1FwRnZVS3IxZEF0Ri9kN2JKQithQzA3U1Vsb01BRnltRGpx?=
 =?utf-8?B?ZUZva2Y1clc1akNieFplV0M5eFBNbnBFaGZ0S1dYSDRsdDNIVG9kcVhBSGxR?=
 =?utf-8?B?dDBpOWNwRmZZS2Fkb0ZyY0VheE1QL1dTUTExbVd1TTJJbmhOZFNwZTdmZ3c2?=
 =?utf-8?B?dXJVSDBGRnF1Q1hQZnhkWHJJNnI5YnlxUjY4ck1ybmZOdGg4N3RhdHdwakZv?=
 =?utf-8?B?RVJ2bTdUSXlhRWJKNmcyM01VQW1XaHROdnZnTFJlV1ZySWwvU1cyUFZMNDdy?=
 =?utf-8?B?Yk9KME5ra3ZibVoxYzAwQ210RkFsNk9pZWJNZnlwM2tFeno1bmJGWHZyS0hr?=
 =?utf-8?B?NGdMaEZOaXRCK1ZJamwreExVWmZNQnZhUzJ3VmIwajlPbWtQOXNmMnFQY3pR?=
 =?utf-8?B?Vi9EQXJNODh2TlR6M21VMzZpNlpGSlVkTjdMazNBUW9qSXpmNTNzZE9qaHZw?=
 =?utf-8?B?WHJMa2t0UWNobG9UYlo4R1ZscGRKYVhXU0RXY3BxU3FhZTBmdm9vMEU2aXla?=
 =?utf-8?B?Q2NsRXJWMk85dEUvVUROK2U5Ly96NFJFQTZSWmh4Rm9uMUwzUjF2aFp3WTFh?=
 =?utf-8?B?TndzcERvWVczc09MdVYyY3ZEWHRXdm9ZZ3MxZ1ZIdWpsNmtqYmNRNjczSlJS?=
 =?utf-8?B?Wlh2SDVsOEliR1ZHUVBRNVNnZ1dRMGtwZ3FUeWNINjk5amVJUGpOMDZZRFJv?=
 =?utf-8?B?MFpSeG4wZFZ6aUcrcytadVpGK1VCSERKMnZXdGpnZEV4OFpZWEI1b1g4d0xq?=
 =?utf-8?Q?UZpHqULo1bUdD?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2335.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2171
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 1bb8308b73c543afa99abedf9ded8a43:xsightlabs,office365_emails,sent,inline:62ed86a2fb091e1d53df26aa891d540a
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f134e303-10d9-4b98-c754-08dd6240dc7d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|36860700013|82310400026|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZndvVGpDSlFxbExqTG9xa2tmR1FkdzNPMjdMUmtwMVRMZk95V2NVdm9jUjhW?=
 =?utf-8?B?VnFmdkdPcUhkaFRaNEEzdTdsNW9vNU9jOVpBRlkzcVNsNVBrdDRUamNWcmdG?=
 =?utf-8?B?TXpVakphSjhtcDJFUldGcGsxbEUxdEtoZDRxWmdLalJmYVdMWWU2SDlyT2ZF?=
 =?utf-8?B?UXFDcldNRVByNStldHREQ2x6eFo3ZEVobUZrNXFoenRXZUgzSms1UGRPbTNK?=
 =?utf-8?B?aEJDTnFvRHdxTVF2UVdwMDZUaFRYQmxGeTgvRndDTmorVkwrM25XTEsrUUFO?=
 =?utf-8?B?dkx3QnRudzlNUGIvU21GWkhweEgvd2lGSEkvbEVKeGJIWjkzdGtTcm1CWEJN?=
 =?utf-8?B?UTNZcDJrT1BhcGZWbXpoNmp5ZzVxS1B2VFZkTFdiN0VobENINDNYbjV3ZEoy?=
 =?utf-8?B?d2U4b0Uxdi91czFWaDdrdVJGYjVrU2U1RWRYMUhEZU5xdlZPZFF5bzJFS2Fl?=
 =?utf-8?B?QzVtelZKYS90ODQ3NHZZT3JGQVY5Ky9tNzE0Y0MvL2czeE10NmQ3UTczNWNM?=
 =?utf-8?B?TUc5dXd0ckhPK0VVVGNqWHFXQXljU21zZTdWZ2toR3hZMkF3MXhJUVNKTk1q?=
 =?utf-8?B?L0RsNzN3a3pmVG1nRkE3VFRDcnZhUWQ2ZjFYWFRHeU1tOWFSeUNScnBCZTdF?=
 =?utf-8?B?NmZaWjFodGFMVU40K2g3OGd1T09BS3pXZVJhazBPdkNzWU83bndrcmhUa3Ez?=
 =?utf-8?B?ZkpnWFB4YWN5Nk50Vks4MzJzUTRqRUVwNmJaRGtkdWRQRFJMMVkvTXZ0YTJH?=
 =?utf-8?B?MVcyVzJxc3BwaEZCdllPUzU1bGgxWm5xS2FqOU8rc0dGTEx5Z2hrelhhV0h2?=
 =?utf-8?B?QWhIUlhRaWhKOXNvbUdBcDZUQjAvSituSmN0V09CR3RIVi9SWHA3QStIRU80?=
 =?utf-8?B?MFNudTkyd3Jta0Z2N3NFZkk2ZkRxckR4YVBRM3ArbGRlWnBEZTE5a0E1UzJK?=
 =?utf-8?B?dVVRZHpJcjhqL3pkaEYwdFVFNU5KTTNqakRyK001UjJqVUpFTGRNbUVFRE9I?=
 =?utf-8?B?aVpyeW5GWkxQZVdlenora3B1SGlFNCs3WGlDS0RMNHZXNEpyT3ZGejlvVmQ4?=
 =?utf-8?B?aFcyYlJuNEllWE0rN2VCOS9vZjhES0VJZkJma0ZpUlk1L1FZTUtQM2RSc2hI?=
 =?utf-8?B?Z2hwTXB3TFJWQXJEWENhNmtFSFNBc0FSYmVOM25hcFlQT01icTVJR1JUYmtS?=
 =?utf-8?B?aUw3bGhDT3FrSEJ4SEc5TEMrdzFoMkZGK0t6ODlITkdIR0o5RXh1NXRDeFE5?=
 =?utf-8?B?VUUvQlppZHhvYXp1TlpUZENZS2tJT0c2RkF3aTM5SFNjOWd6OW42UkRxQWlv?=
 =?utf-8?B?ejlaTDZSYndkeEozbTg2OTZLaTdHQ0h2RGtJL05VVmRzQnVnQ0NuQm9tYlJJ?=
 =?utf-8?B?Q2FLdGR3V083QUZGMy9tdUsyclRNRkFYK2t2MDZDR3pOV2d1cmljdHZlVkVU?=
 =?utf-8?B?ZGl0cG04bnh6alBNa2JKbC9MSFN0ZW91U0ZPY2wydVdwTFBLN1hRTk82UmhG?=
 =?utf-8?B?NGxuc0JGaDZNUWxWVTRRZzFTOXN4NjJ4ZkhzWmdwTll6aHNMdjRvSWk5VDFZ?=
 =?utf-8?B?QjlPVFhCZlVDbXp1N1ZEWXlnTXpjWjlLK2toL3REc3RqQkkwUDlxVFlpZldC?=
 =?utf-8?B?UGExblgrMUhITloxd2lJdUJSK2ltQ1N4NVF3VmVMK2M3d0d1clVxNGY3Zm5p?=
 =?utf-8?B?clNQaTNwam81WTQ5NmFFaU5WWFU2TGhuSzBFUjUrR1J3VkxqNndmQUhXTkxU?=
 =?utf-8?B?M01ZQ1IwMkViazMzTkwxYllGb24zS1ErOElxSkdvbUFFbitwQ3JSSzNVeFow?=
 =?utf-8?B?WGpqRWNUbXNPVGp4dnd2WGgyOHJId0F4cWVKc1dLeXJxeTh0K0ZpSWlta0Zj?=
 =?utf-8?B?Zk5qNFVxN2o3bjM5YTk4b0RQeksyTWJmTDhJZmJWUVJXWUtZcTFNMnpBSHhU?=
 =?utf-8?B?dkQwaFRKTzhSTmdjOEtlRi9oYllIR1NSS1pDVnNWSlJ4Mm95VVpJZ0hHdVBD?=
 =?utf-8?B?dXhMU2k4RzJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(376014)(36860700013)(82310400026)(1800799024)(35042699022);DIR:OUT;SFP:1102;
X-OriginatorOrg: xsightlabs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:08:19.9362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaa6afa-6b20-4477-1f1d-08dd6240e412
X-MS-Exchange-CrossTenant-Id: 646a3e34-83ea-4273-9177-ab01923abaa9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=646a3e34-83ea-4273-9177-ab01923abaa9;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0899

On 3/5/2025 11:38 AM, Sudeep Holla wrote:
> The PCC mailbox interrupt handler (pcc_mbox_irq()) currently checks
> for command completion flags and any error status before clearing the
> interrupt.
> 
> The below sequence highlights an issue in the handling of PCC mailbox
> interrupts, specifically when dealing with doorbell notifications and
> acknowledgment between the OSPM and the platform where type3 and type4
> channels are sharing the interrupt.
> 
> -------------------------------------------------------------------------
> | T |       Platform Firmware         |    OSPM/Linux PCC driver        |
> |---|---------------------------------|---------------------------------|
> | 1 |                                 | Build message in shmem          |
> | 2 |                                 | Ring Type3 chan doorbell        |
> | 3 | Receives the doorbell interrupt |                                 |
> | 4 | Process the message from OSPM   |                                 |
> | 5 | Build response for the message  |                                 |
> | 6 | Ring Platform ACK interrupt on  |                                 |
> |   |  Type3 chan to OSPM             | Received the interrupt          |
> | 7 | Build Notification in Type4 Chan|                                 |
> | 8 |                                 | Start processing interrupt in   |
> |   |                                 |  pcc_mbox_irq() handler         |
> | 9 |                                 | Enter PCC handler for Type4 chan|
> |10 |                                 | Check command complete cleared  |
> |11 |                                 | Read the notification           |
> |12 |                                 | Clear Platform ACK interrupt    |
> |   | No effect from the previous step yet as the Platform ACK          |
> |   |  interrupt has not yet been triggered for this channel            |
> |13 | Ring Platform ACK interrupt on  |                                 |
> |   | Type4 chan to OSPM              |                                 |
> |14 |                                 | Enter PCC handler for Type3 chan|
> |15 |                                 | Command complete is set.        |
> |16 |                                 | Read the response.              |
> |17 |                                 | Clear Platform ACK interrupt    |
> |18 |                                 | Leave PCC handler for Type3     |
> |19 |                                 | Leave pcc_mbox_irq() handler    |
> |20 |                                 | Re-enter pcc_mbox_irq() handler |
> |21 |                                 | Enter PCC handler for Type4 chan|
> |22 |                                 | Leave PCC handler for Type4 chan|
> |23 |                                 | Enter PCC handler for Type3 chan|
> |24 |                                 | Leave PCC handler for Type3 chan|
> |25 |                                 | Leave pcc_mbox_irq() handler    |
> -------------------------------------------------------------------------
> 
> The key issue occurs when OSPM tries to acknowledge platform ack
> interrupt for a notification which is ready to be read and processed
> but the interrupt itself is not yet triggered by the platform.
> 
> This ineffective acknowledgment leads to an issue later in time where
> the interrupt remains pending as we exit the interrupt handler without
> clearing the platform ack interrupt as there is no pending response or
> notification. The interrupt acknowledgment order is incorrect.
> 
> To resolve this issue, the platform acknowledgment interrupt should
> always be cleared before processing the interrupt for any notifications
> or response.
> 
> Reported-by: Robbie King <robbiek@xsightlabs.com>
> Reviewed-by: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Tested-by: Robbie King <robbiek@xsightlabs.com>


