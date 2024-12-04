Return-Path: <linux-acpi+bounces-9920-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EDF9E454C
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 21:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11202845D8
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 20:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194D31F03CE;
	Wed,  4 Dec 2024 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLB5XhF3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190A1A8F8F;
	Wed,  4 Dec 2024 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733342985; cv=fail; b=CgS+t8LFFHRe5V5JqLwvGmFhpaI5w8L4rQ0XfjJRYMzFMqlSKQsf936mxqS+UnqBIQUdYHTyPVzLKToeGEN/fYOIuaY24Mi4sxsp+RtRKivivFTqo56iM4NAnTBXIDcm+mtcNP3veGJMeIRgQE+k+RQypU2/8XwDadRv8luonXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733342985; c=relaxed/simple;
	bh=9YT1bye8lob/mFUGeqtzipVYecrKP0PAqFtqhv7Tlro=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mKDCPNMDPm68/d87PDWDeqREX2Tj4XFWDQY3WVUYwyI4lIbsPiXohKPeqcAOKc2cGvY/VnwxyLURwOOIhb0t4KespZvNz4iLXyQCxd4rIP9ieUbEUzR62GhfzxuWpT8ZusSmTwQ4FGveiL2pzrpjTUAE3meLE/UplrO4j0qR53I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLB5XhF3; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733342984; x=1764878984;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9YT1bye8lob/mFUGeqtzipVYecrKP0PAqFtqhv7Tlro=;
  b=MLB5XhF3zSjNSvN01zonSl/TA2XCC3kySWYjIAC1fHYueqvi1fWL76SU
   Ij5mhB0pdFUS6LB8yRKKVO5AiGlN11LiX+Wjn7Y4JPy2EZ01N5YH5CqlP
   maYBLrxi2ktfjZoWf2pcu0G4NSoUOuR9+uL/7cZ4nERhwz/ue7Ost9WNx
   RDQ88BTsxfO3DX2H+llBw9m5TFKQkmG7AULE26MEyoKaqR7uhJditEw6c
   7X3Htk7DAwCrZgICghxDTi0P5wcubsCY3q+v1duzoFy+x2SSvktwtZy6Z
   1nkQhCpVuaVk6KBtPep4S5Q5fCWwy0T0z/k8Sd7zP5dgAqQoMg635yXFB
   Q==;
X-CSE-ConnectionGUID: XeBtI9VPTdicZ+qAXlS1IA==
X-CSE-MsgGUID: h0uz7DaIQ3Wiq/jWV3fYLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33777075"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="33777075"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 12:09:43 -0800
X-CSE-ConnectionGUID: xxwb+hm0TD6OFAzeB7Z+yQ==
X-CSE-MsgGUID: CYjrqAV9QQSQ1ERz4H1jMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="94230449"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 12:09:42 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 12:09:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 12:09:41 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 12:09:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXnJce6ZXQ+lxJIgj4qM8xz6KAp8cOC9SmtsxVJukchEUDcSqiEZFHL/QfRVQU/akS7CvWSPTAEngoCFCiGgc+adszizObpdFQ4CNeZ6J0lIueJkc01aQuNQ9RkYvc7MGFKr4T5rwhp1lhWd3MBVGnyOSxNC4Mq9LM/dEZXZwIXWxa9aE2h10FxpqauUDiBd2ecvClT1BJDZE2rPhfs2zWQU+/RjxAGlYgdqtMm4cZgCSVp260ZPebe6R+eeW1f/q2GqvsqFoxl/b7dzQ/zfzGVPik+wsu1EViHO47ylCWtp/qbhn2eN5TDhy0UYXCIprgegvSTsdc/KhYXqDKsgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hmcmUq3sLQXMUmicLLid4HWpJRM6Iq2eSnMyRBes1I=;
 b=HO8B/gcBAnIQWZYTYtqQvFiXE69FnBknkwOF2UKL6SbIihB6YdeoLIk+8uNwQen5xahlQCCaasHvlcYCofIARk1odIAsYbIUgg6z/chYWjMDj0Vuwpt14mi05GuC3Ikqi0RDYCWH3r6YP5lnYunjsSyf4bFHaUQUNROJRFLSR8mjbxUQRpEZ5x1g6NOEe/haTlN5w+Pzut2LNHBVx9i8OHpDpw4fcgorvb3ux2YnC5P/Pm36tSpdY/gs33mXK2pCDNXs4IHsM1F9DkPyKamcCiVMaDFL1ht16kcxLkM5W3d8SU0wCWJ/34w9JyhWGRxl12s3c+h09KlqGWY3my+djQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4568.namprd11.prod.outlook.com (2603:10b6:208:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 20:09:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 20:09:38 +0000
Date: Wed, 4 Dec 2024 12:09:36 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Dan Williams <dan.j.williams@intel.com>
CC: Priya Autee <priya.v.autee@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] ACPI/HMAT: Move HMAT messages to pr_debug()
Message-ID: <6750b7003ed08_2508129452@dwillia2-xfh.jf.intel.com.notmuch>
References: <170668982094.318782.2963631284830500182.stgit@dwillia2-xfh.jf.intel.com>
 <CAJZ5v0gTc_FzwkSxPEa7izbDYz6BWqx72TzEXxHGd3MRR8EUFQ@mail.gmail.com>
 <0ca3dbc4-e791-404c-8058-2b2c24051f5e@nvidia.com>
 <48ee2dde-de1b-4af4-91c8-eebb4e15e191@nvidia.com>
 <c2c5a70b-8b8c-414b-813a-f0a82562f718@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2c5a70b-8b8c-414b-813a-f0a82562f718@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:303:8c::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed6fd42-33f0-4183-ccee-08dd149f948f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0RKTG80cFVQaWk3NzlCOTFSREZobFN3R2o0QzlKME4wUnRuaDZqeTE4WWg2?=
 =?utf-8?B?a1M0bnQ5SXNMSVg4bGZJM0dCSEZGKzNVT0NTVmRuVE9kWks0aWttNE0yUFJn?=
 =?utf-8?B?MFp2UXIyOW9NSXdsb0xicER5aTdqVHZNejBFMWR0dkxQTUgvcVQ2eFRWNURi?=
 =?utf-8?B?UjY3QW1PaS9aL3BTcjkrdlFLbVN2K0RxQVhkdTdHNXQ4a3YxQWJHOUF6Q1VN?=
 =?utf-8?B?TFYvZ3lWdHVTcFJPQlZEV1FXYjl1VVc3aDFUcUF0QmY5eEVDQUsxM3JNRzBX?=
 =?utf-8?B?SS9uYmRZbVpFemZSMUFlV1VhcE5HRnI0WXF6VzhKZmh3UEtOTUNGYzdVWjZa?=
 =?utf-8?B?R2JjTHh1ZXYybkhwUEpjRmZtckI5TFZkR1FFbWtISmxScG5oQmo4Q3RwVDY1?=
 =?utf-8?B?WXJ0bFZPeHFpYzVJZE5obGl5WTRnd05Od3dCa1d3UGkxajZ4QVp0MzFkK0oy?=
 =?utf-8?B?MWtFMnVpU05UeS9Gb0VZM2lKTWxHa2U1RkcrMWpUTlZQQS8yV3BVeXQwODRa?=
 =?utf-8?B?eGM4aTd0MkJhL1J0cXZZTWN2U2RzVWtlN2d5ZjRkTExGOC95UGduWXRzdlF5?=
 =?utf-8?B?NHBWcmtST1ZDVnVuUFJMc0M0RWUwZHU4dVZSMG1iNnpycFhrQXZkc2Z1WHNJ?=
 =?utf-8?B?eHpWSUMvTGpabENPVXNNZmo4Sit1Zm1YQ005OTdwQ3NSQTVpVytYV2VDM1JV?=
 =?utf-8?B?bFBZVG1QallYdkFrMVQzSTROMkY2T00rYVIvYTFhaW5PZTdBSTIwTXBTVFhM?=
 =?utf-8?B?NEZRL2YrSTRtdXI5R0xFMUY2c3JPdU05QmZ3RGNiSWN2ckFRV1p5RWg1UmFR?=
 =?utf-8?B?SEVucXdIMjduZlJmb1g4dlVONWtzcTJTY0pwS2Rib3lKUDAxU1AzWGR2RlN6?=
 =?utf-8?B?L3BBV1RwMU1CcFdTUWtTY2hUaHlBZm9wdndYT3B2MzliOW51UzNwd29WRGJi?=
 =?utf-8?B?cE5Fb1RzSlJsM1R1QmhneHVWN25qcTh0dTF3eWU2cVVQRDlpZzU5dFJTc1p3?=
 =?utf-8?B?M3lvRkI0akc4MldDYjFaRFkvK0NxaGp4b3hIQjZyblNhTWxPL1ZwZi9XQWdC?=
 =?utf-8?B?bzRHQ016LzVTc2dERUp2SElFOXB1RDVFZDdHQnQ5OTNlUlY5aGs0eCtrUERh?=
 =?utf-8?B?Tm9lQUhWZkdCUW92NDZNUXJoWkJzcHJKcnkwMVBHRG9LMkFuS1IzY29kZGZL?=
 =?utf-8?B?dXF6SE5ia1VRL1Bpd1UxNkd4RTAzZnlYZ3lpTWNnZjdXcjhub2JQOFpCMit4?=
 =?utf-8?B?TVFDdzVqb3Q4Z3hhUStBUCtWTkEybmdKYndjaUdnS0E3U0RBWjFRSHBEbnYx?=
 =?utf-8?B?SXhRQXhTTi9LSXUrYXI0S2pSYzJ2c0tNSXFhQUZNdWZHbDlqeHpEb0NRQlhI?=
 =?utf-8?B?UmhNcWhMaCtoT0tiQzRrdGpiaGhRdUsrRU5MRVFKV0lQandlWXdKYjQ1TUxh?=
 =?utf-8?B?dVdROFQ5cUh5WU1MRGlvaVRxY1hza1dCalZMblR5VjdZSWRHNnFmNndGZ01N?=
 =?utf-8?B?enZqNWwzZ3BzTTRvQjM4UTFoZlFsR3VXU1IwdGl0WUFzZDZZK3QyNmJWZXRF?=
 =?utf-8?B?eGY5YWVBZ29vRkQ4UmdYTnprdTFpSzlKdlBYWDBURWFoU0tEUk9zSUovQzFT?=
 =?utf-8?B?ZGlhWXZHb253bytJeGdrWk9IbG55MXBBRDlBSHpzTzZiNlhJSFZTRTd3S2hQ?=
 =?utf-8?B?QzA1bGlSbWl2ODd0Z3JyRVdvVTNhMEYxL2JpanJQcVdUYmpVMTNlUktOWEZJ?=
 =?utf-8?B?RDAzYUIwOGxzd0xhTW9FSHV6R2xOd1VFMDBaSDFHYjJUSm9qOVpDSUNLY29q?=
 =?utf-8?Q?VeTvfpr/crPv9CTi7ZVuQPyN2eRwChpUfTw6M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVRwZjd3MGVaUkgrdmNmMmlVdVRydWhrU2lWaE84cDBQK2RXTldrNFVWbW14?=
 =?utf-8?B?SDAwZTJkZTk3WTQyb1RITHUxQmp4T2t4d0k4K004eUtVTWR3K2tFNVF1Q2l1?=
 =?utf-8?B?V0d2ZUxOR3ZVMGFhUkh1Yit2TWNaS3lxejAreCtrcFhWU1VoeHBxSitTUkxp?=
 =?utf-8?B?RGM0L1NwSWVrbGdJMDNwdGxxZmRPWHJsbG0yVmRDZFArNkZXWHQ3VFpCS0Iv?=
 =?utf-8?B?OUV6RVpwcjVKeTk2TTc0Y2x1NkMyRHBkaEIvaFRwTzFRWDVJOW1CTVJ0RXRV?=
 =?utf-8?B?V2xkdk5YNGptRHg3ZkV3NWxrRFdkdFFtSTFmM1ZtWGgwY0VpY2pWS1dpQnZs?=
 =?utf-8?B?N3FwSWMwR3ZsMUs5MDFBTlZnNnRKbTRYN0NPTVRGSTU5SXVSYzJvcFJVVksr?=
 =?utf-8?B?NUplcFlkdEhKRGdjbll4b0Rwc09kYzJvUEhUUld2QXk4ZFBJRjZPSWNmamVU?=
 =?utf-8?B?Yy9UM3grUGpnSjJ2N2Q4Q3AzUFQ3L3J2RzN5SGJobFYrUEFSWU1weU9zMUR0?=
 =?utf-8?B?NWNLZFdPS0JyMHRKMVQ0UlJxMmRHdnZjK05KSVdrN0M0ajJrL3ZldWRmT2dT?=
 =?utf-8?B?bXhJOUN3cFlQd2s3S0NiNEJVczgvVmJNM3FGbCs0QlB5UkluZ042NEtNUzVu?=
 =?utf-8?B?QUJjWUNRRWoyajBKZ3pjcGFQM3E0SE5TaGNodk8vMmVTcTc3dE5HZ3pJeHNo?=
 =?utf-8?B?eXJKWlRRbTBmd0I0akdLejF1Ulo2Rk54cHlpRkxYMEMxZHpNc2htWHd5bTJI?=
 =?utf-8?B?ajlMNCtySzhhZHZWYlc5eEsyOHFBRWZOTlBPYTJBOHFONk5VTEwxem5oUFZu?=
 =?utf-8?B?c1BwMi9GaktDdWRkWldYS3NqYW51WnpSbWNVSzF5ZmQ4dU5IZUVoZVk2My81?=
 =?utf-8?B?VTh6Mi8zbnRBQzBzU0YwYzEzcXR6ZlA0Y0lkTDNmL25TY3h5YTZOK0FZaUFp?=
 =?utf-8?B?KzBNMlp6TG5pbFdMcEx5bDJ4eGozaEZGZ2V0N2pqeElsSjl1NndvTHpYVlRu?=
 =?utf-8?B?aExYNllUSUxPRHJRMnZnV0U4NTFLeGs3c0grQmpoK0MyS2JKcEpNcVRsNUk1?=
 =?utf-8?B?WE5CL2x4bEVBQWJ3Z2lvZVl3Zmx1Y0pYcVhFdkE1QkwrVC83bVNNNThpc2dl?=
 =?utf-8?B?bC9GV1R2bDROYnUwcUdJQzdGZWRHQkg0YXlZQWU1RzZMTW9tcnQ5a3BwMHlx?=
 =?utf-8?B?NWFma1MrSzZxaHo2SVpDWWhkM29LeVZyVDVYaGJPSjhyRUZXVEtwNjVJWWYr?=
 =?utf-8?B?QzE5Mk9xS2QrM1E4cGUyczVTTjBkZ1I2ZlNJZDlRMmZEbmc5YlJ6UlQ5MWN2?=
 =?utf-8?B?YktORG9JdjBZU2NJZ1lvSmsxVnN2Vm5PM3VCVkp0NzdkY25FZko1NEJwNFN0?=
 =?utf-8?B?TVozQWFENjh5OXBLeXB0akNhcytxTitvMW9Pc1RCK0hibFFtZVcyc241SVJ5?=
 =?utf-8?B?NThzSXNnbHprekphZTZiVmJKREd4djc4M3I2b3NtRjl5L3RDYSs1R29aWmpx?=
 =?utf-8?B?RExxYlovWUVoemRtUW1qZjBYVmFJeVNKQU1WSXJRWHhYZlpMYjlmL2FhV2Er?=
 =?utf-8?B?MTJEbUpYeHRMbmZsWGNkL3hDYkQ0YUw1N0E5b2JteVlCSjR5Sjkyd3pIUU4z?=
 =?utf-8?B?dnkxY00xbmVDNWc5THllZGpWQVIvcXo2ZzR1aUtUZjVkSWt1Zm5tQTA1WGhn?=
 =?utf-8?B?VGordWxuaHYyRUR1NENBdTVDWWVlMXFrazNPank3ZFRzTjJsMFZMam16WTk0?=
 =?utf-8?B?SUtNN1dveXdEVm1QejVJWGMvKzd6UGFFTXB6akx3ZDZZclZEcE04blpWY0lD?=
 =?utf-8?B?QUd0MWtVbzZWM3Zwc0p3YXM1dE5IamhIcWEwUSs2SUJGYlZ0Ym1GNUxhb0Qx?=
 =?utf-8?B?VkE2d2xhTTVKZkppRHhWMks0aWpJcVh5OW1EUnNPWHBnRWVPaUgvbkVhWTFI?=
 =?utf-8?B?QjJqT3RoNyt3VHArbkQ5SjgxL1NDZWFOS1JhSC9aaXVpNUZJU1FTR1NnUDc0?=
 =?utf-8?B?cTNMV2Q2bFRsYjFvQXlaZ0hvMkZROU40bDIzeGFzek9KYjBtMG5kVEhtbGc0?=
 =?utf-8?B?c0M0UFdhMWoxTWlWWlVOeENCTnVyazNTUzFpQzYveDNqMXR1Zmd6d1FMRzZj?=
 =?utf-8?B?a0Z5WEVENFlkWUtwSDZwWFpWc3dhT3VpUEpiZmlXazE3NVhuZmJOOTFSYUdM?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed6fd42-33f0-4183-ccee-08dd149f948f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 20:09:38.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaMA54HwXbs0SGzWlcgduAYTXEnXTm9cVyRpywhhWQxXO6fRH5vuLLSSmNwNBTjOpOm0Zh4O2sI25SyDixayQ83xsCYNfRb+sUSg5/KEoUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4568
X-OriginatorOrg: intel.com

Kai-Heng Feng wrote:
> 
> 
> On 2024/10/23 10:02 AM, Kai-Heng Feng wrote:
> > 
> > 
> > On 2024/10/7 11:03 AM, Kai-Heng Feng wrote:
> >> Hi Rafael,
> >>
> >> On 2024/1/31 7:54 PM, Rafael J. Wysocki wrote:
> >>> On Wed, Jan 31, 2024 at 9:30 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >>>>
> >>>> The HMAT messages printed at boot, beyond being noisy, can also print
> >>>> details for nodes that are not yet enabled. The primary method to
> >>>> consume HMAT details is via sysfs, and the sysfs interface gates what is
> >>>> emitted by whether the node is online or not. Hide the messages by
> >>>> default by moving them from "info" to "debug" log level.
> >>>>
> >>>> Otherwise, these prints are just a pretty-print way to dump the ACPI
> >>>> HMAT table. It has always been the case that post-analysis was required
> >>>> for these messages to map proximity-domains to Linux NUMA nodes, and as
> >>>> Priya points out that analysis also needs to consider whether the
> >>>> proximity domain is marked "enabled" in the SRAT.
> >>>>
> >>>> Reported-by: Priya Autee <priya.v.autee@intel.com>
> >>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >>>
> >>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> This patch doesn't seem to be included in the tree.
> >>
> >> Is it possible to pick this up in the your tree? Thanks!
> > 
> > A gentle ping...
> 
> Another gentle ping...

Rafael acked it, so he probably expected me to take it through the CXL
tree? In any event we can get this queued up in cxl.git unless Rafael
beats me to it and applies it.

