Return-Path: <linux-acpi+bounces-18681-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD4BC42362
	for <lists+linux-acpi@lfdr.de>; Sat, 08 Nov 2025 02:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9781E3B1309
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Nov 2025 01:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11702D7805;
	Sat,  8 Nov 2025 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlH3wA2b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64882D5944;
	Sat,  8 Nov 2025 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762563968; cv=fail; b=Hjh5pmQcp2lmvek1RLnn90hgNU5qVvbSB/H4IhOubNDQ9zwfhsYwPVF5wKaiYcZv4VgjilLLw5I0UPNwJ7ahQY8BQpM8jPo35Z5nMNdX8MrFUnsjRpkXK7IPc1qx13C3I9Ecnp0FytpCdc7DqkADhjDekBPnK0Nvccz/elGIEeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762563968; c=relaxed/simple;
	bh=rM+ZZKmi8LwURMK2KdBMefSJhOQxIS/YTeS14rBGYE4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=FHmjHF93TOj75nrYgqBOWeDaCr6aZIenWIivD5f/37ruor+4M4QQiQCHCGWSigizpshzRAVK7q7Mi1yGgmgQM/xSDE8S6hBwoObT86WVu9JlhbF102lzLupO6Cm2svnWpoW29Pz+ge/BnOU12Ct5Iio9a56Vs+dZqt9n+DYmQ/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlH3wA2b; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762563967; x=1794099967;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=rM+ZZKmi8LwURMK2KdBMefSJhOQxIS/YTeS14rBGYE4=;
  b=NlH3wA2bt+sHxdQ/5bw7MG5LfDgWCf928gOxcR3SXeZySJL2Itm6effm
   eEjjL8m+iXDc8t2c2k1o9jrxydfTvAxbVAJxRtlnktLlThMbeT4UPqRl/
   xD+ns7lLSEHi9qlgxtLI+sQwD9IGBVNKffxT+038lsd5caJ+Gxpeg1854
   mXpHHyTg/mslOcCUUp15oKTAN9kkEvTRIWu6SFsmqn6zA5+Hr9jsL8Ohi
   PH5hKXBIdsARvNb/oPkCpHEmf0b9iu1q9J2egXUUDeo0DMp09xxq9qwqn
   /pgvDR+8RyOkYh/aKUs6YViyzznlx88dCLiCtvPRh815Ge9KOkclAhMXI
   Q==;
X-CSE-ConnectionGUID: b6/ihdDcQoWoyg9jBvNAJA==
X-CSE-MsgGUID: PMVxnA0YSFC3LSAvP085UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="75009465"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="75009465"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 17:06:06 -0800
X-CSE-ConnectionGUID: B71kzcHKS/yrHXcRrvVvlw==
X-CSE-MsgGUID: JDEu3XclTN+6dKuGrknP+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="218833933"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 17:06:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 17:06:06 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 17:06:06 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 17:06:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5LsWggvvh/5/WRbjqt2Y8KzyefQS+CZhmn1MQuic1vfqw29HOeCRWH97NXunkCPSgnd0uqY5C0gCCiGO2QqZuKm6VCSl/hrWrzo/QRMRe8oSUs7/9d8B0ZcJogXATglzFnFxEbwzuJIdAaFK5gE9HKPUwdRkJsC0RwmXpWCRUxNPlwtTYy7HhI3zzmflP97cPmao1l4K3L+8hOAfY3sqWEdkNrf9gWppoFeJSviN2+Azq8VmPKTy/5ecbr2rCygjQ6PER2YKI2BGxGh1ZZ800Xro/+TcXDVkxcZjS3w5oWRU6HUpEC4Unzj03SjwHvel716PA7EkY0THwZN+rCsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gev0CQWOE/cNybQVrBvrgO5h4vJuEaPb6OgMrpC6Les=;
 b=LccO/qKKnYJeDsN2QlOdnGMh8g/Q5xLqaRIVY4MgcP2O9EZ5PS7k7sQgiywrbXkJQgtNAgAs9/6fJFbuegWzwlnJIHjgnPbIi67CSzSJ3GzhAb+8nMI+CYASj2YD47SFQ4VgWjZRl50XhFtuMFdiNM1z3toOfr5+zsfDlY1u+L1M4sD/qOvedWw3HTE+rb6f4zwDZLJxdHNa3Cw0q6NckxHABWj6jk3+8iVb6d0oCS+4wExmMjbKRrKQFlsYzexc0Tift2do3y1KENYLCXnSd3I2St59wiQaX5BnEvrKrg8jhdHWT7YPpqr4RVJ+QgdTzLK7Zm4ECk++l2UUpfbDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8675.namprd11.prod.outlook.com (2603:10b6:408:219::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 01:06:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9298.007; Sat, 8 Nov 2025
 01:06:03 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 7 Nov 2025 17:06:01 -0800
To: Dave Jiang <dave.jiang@intel.com>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
Message-ID: <690e977966ca5_74f59100b@dwillia2-mobl4.notmuch>
In-Reply-To: <20251105235115.85062-3-dave.jiang@intel.com>
References: <20251105235115.85062-1-dave.jiang@intel.com>
 <20251105235115.85062-3-dave.jiang@intel.com>
Subject: Re: [RESEND PATCH v4 2/2] acpi/hmat: Fix lockdep warning for
 hmem_register_resource()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe3f9fd-c296-4841-c4f2-08de1e62fca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2oxbVl0TnVQTlErbWZTcVV6TG5YUDVKd3YreTRZRkF6bUQyd1NoMmNPY2JW?=
 =?utf-8?B?MmJ6cCthQVQ5VGZ4ZnFmSUZFYzNTcmU5bU94UDFPTHc5dzRTMkdnSUFUTVB6?=
 =?utf-8?B?Sk1idUtOSzNTWnJNa2pCV3UwNHlHUStzZytuMkEzS3dkR3JmSk12TFdRT1Av?=
 =?utf-8?B?UlpWWlcxa0dINnlrVjl0RHcxNHpaelUrRU0ybkhRRjJWTDNSa3k2VmswdXNS?=
 =?utf-8?B?R1U0SVYrR0UyUytzVGYyemFuYjlZeDdDSGFrM0M3SS8xOStpWlRCRHRkcVJm?=
 =?utf-8?B?OU02UDU3WFJSb2Vwa1NSRlkrc2FLRzlmYmRaWHZ3dnBjN2ZOcGt4VzJ5YUQ2?=
 =?utf-8?B?MHg0ZVRINFBFdU9qK1VPZElUOUgrVUx2UTJJNlJxVmFsb1BBYUIvL0FIbXQv?=
 =?utf-8?B?bTBzWmZCZi9rb2RZbkJiUFM4WmlWU0cyYStSQy9EZStKc01iOStVcFFtK0Zp?=
 =?utf-8?B?WWFCZGtpb1MvK2d2amdndkRLVHVHbzBmSVhQUDJzTkRnQll1Rnp0eklPMG5U?=
 =?utf-8?B?NWhBWWdjREYzY0hZa2NOdXJRdEptSHg3djE1Y1FFL08rZ3g3eE1LS3FPUFBT?=
 =?utf-8?B?L2lTT2tIT29xekhScjFNYWtXUDB1OEoxWEdXMlNDOHh2MkFjMnpOMGRXeng4?=
 =?utf-8?B?V3hEdjE5d0NyNDNEQmdINEtzd0RZZ3NUL0huemJPcGZMZk9wSUhuRVlyZ0NX?=
 =?utf-8?B?VlRWcnZRSy9HYkZ0Z3JIOUdMNThWdzFuZHFyMXRWRmZ5UVY3YVF5eGNqanVE?=
 =?utf-8?B?K2E4Nm1ndGg0VkJ6Y0tZQUsrVjk0dUhiZ0pzQ0dRS2UzKzJsVkw5SWhoWFln?=
 =?utf-8?B?ZlB3bDdrV05UTlVBM3BIOGQ4dE9CcWdlT3NuWk9sN0wzWXFKWHRkRzlwOHl3?=
 =?utf-8?B?b1dETlFwRmZtdkRKbnBMekVyZFJVUSsxZjNGeGNIS3B0Z1lTRFFsSzg3UlpM?=
 =?utf-8?B?T0tsVEw0WXNIQVNScFExMW9uS1Y1aFdrQTdoNFV6WkZ0Mkg2U3FMc1NLemIx?=
 =?utf-8?B?QVRGZEM4RnpKVTJoSVdHOUtjcmN1R1paYk96VXA5bkxrblh4NHZxT3NHbm8w?=
 =?utf-8?B?ZUNSVjhub1dVOWtJZ0tWVlN0aVlNVkZSRm8zR2l6SDNiZ2ZkakdCcnZXZVV6?=
 =?utf-8?B?bVpZUkY2VXhVOGdZVVgwMjBlTENQVWJMTlpIUUhwYi9oRmdUMGpIaFFiY0lD?=
 =?utf-8?B?K2hraUVIa2VGbS9oWkFIVXdyUzNqTHZIZCtxc1NIcllEUUZ6Yko3ZDFzM2Vk?=
 =?utf-8?B?bFYwVmdZTi8zM0VJVExJNTJ4SUNnNHhmbm13cVM3VmlQUHRHdzFXbXFuN3p2?=
 =?utf-8?B?dE9Ha2xoNzFFUmpCR0ZCSnpJVG0rSWlyTXNGQTFCZFRRaUFTV05heEdpekZH?=
 =?utf-8?B?cnVsT3pxTDM3a3NML2JJeTVvY2dINERFOVBBS1owc2pWOUE3QlFoY200WStC?=
 =?utf-8?B?Q3VIeDVuc3lmeGhwQUNlaWc0bEEwdFA3d3JiN0JyQlJrM2pZN2RmY3ZPYURO?=
 =?utf-8?B?N3RrQXIvdWwzK0M3TVd0MVJONmxwNHF4UGVzYVNWSVhSTWEzandSZ1BMK1lw?=
 =?utf-8?B?OUdkdFVmSEJINUQ5TUJvSjJKUm5vNWtVeVQrNXZWV0U0aHhxMWJ0TWxkdzVD?=
 =?utf-8?B?TW03cml0YU9BM0pHTXIyNDQwZDF2Z3Bma2tyRUtqeGN5Z1pUSVNZRzBCZnhi?=
 =?utf-8?B?a0c2ZHlOdkJoV0hXWkE0UDkxWWdqUzd6WVJZSERCRThoSDFTVS95R3V4Rklt?=
 =?utf-8?B?MjZsUVZOZFQ4MzZlZitXVGs1NFhZcFNIcHRMbm1jVWh4RDBuYUFNYS9vUHp6?=
 =?utf-8?B?MFZoalByQTdOKzRBbldBdXNDR1R0Y0JuQitFSmRQSEpKNDRxdHRVc2VLNDZw?=
 =?utf-8?B?VjQ3Mlc3dVZ5dEdoYlJKblVOTGNoMkFLc0NMbXR3Q2ZHVWUrL0tmdUhtWldH?=
 =?utf-8?Q?9lzZKze0t0p8SfAVBXz+jCA2o9P/0DH0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clY4UHlYcTRQU0ZKNjlLTCthM3FCRDE4dldETDlrdGdpWTUyaWEvVERpOU9u?=
 =?utf-8?B?d1BnOFFvZUkra3RycUFvUjMzRVF6RDNxdjlRNGNiR3VuaVQ3Tld1dnBEaDYz?=
 =?utf-8?B?dkhRaEpnU2hieGwxMk5iWFRoTGpEakNXU25tYkYwZ2xMVlp6enVEWnFHblRz?=
 =?utf-8?B?OXBVeEtaN3prV2R4RHUvUmtvcjA4NHBDTlI0KzBWcXErTzhUVVRIKzloMHJX?=
 =?utf-8?B?UFBRVmlsbTBlMVZFOTFQM2x6a3BZNjZKMUhFaEppUVJvblR5aXVuUUkvTWFY?=
 =?utf-8?B?dXRtbWZSQTN2Zklwd0R0YTVCcHVzQWZpNEtZK1dVN08zeEZPZkJDbE8xMFNk?=
 =?utf-8?B?UDlMaG0rcUxaY0Z5U01Vems3VER0YkQ0QXVxZUZSUTFjVnlRUlArMHQ5dGty?=
 =?utf-8?B?MUF1cVhqOGpTZk1mWnVnclB0a2srWk9LdkRDdGozWVBqVk5USWZFSkJ0NW1C?=
 =?utf-8?B?MEJpdnR0RXVvZGY2ekJIM1JxTFg4dWpTblVDL216bDIwbzhDbmMvNjJwWXpQ?=
 =?utf-8?B?MCtOMUxaWUtRd09NekduemNGT09XaTJSUTloZlpSS0tUL0R5dS95UGJ5WVpH?=
 =?utf-8?B?WGcvRXJPNnlqdFR4ZEhqNjdlcXprMVdvOExkSis0elFhWUhya05CbmtzTWxw?=
 =?utf-8?B?YjUwSmdXdm9YTFFRMVdWVFY0SEdubW5GeHlOQmR5c1BsbGk3aHg1amZ2K1Za?=
 =?utf-8?B?MC9qUmR4NTRHS1BsRCsyZjJhb1Zld2NhbzBaNW1KQXBKSzFKTzI4UlhWem5N?=
 =?utf-8?B?cXBxaUVlY1RqUmJPMnRWRHFEWml0L2x4N0RSZE9aR2FFd0tWQ1M1OHJ2Sm9a?=
 =?utf-8?B?VlQxWEhhemcwZGxzQ1VRK3NCRGE3dFZpby9IRThZRHJJYlRmbGNKVWlCVGpa?=
 =?utf-8?B?UWdqenllTWJvVEJyMVozdVB3Mk9oTHhkM3dFM2gwcERYSlkrTENYYWdzTkIx?=
 =?utf-8?B?OG1WTnpkZjBUc293eFZ0RnRid0xCTy9hV2Y1ZTN2NVhPa3NNZkU5TTRTRS8r?=
 =?utf-8?B?OVoxSk5qWjV1ODI4WmZUWjcybHk1RDF5UmdpMDlodzBwUndRbVgrZk93N216?=
 =?utf-8?B?aUt0RW5pdGNydHd4SS82YUFLZzdaUEw5Um5STkQwbEprR0s2b21YSlVjcEFJ?=
 =?utf-8?B?SlJ2UXBXWXF5WEc1MVlwL2NlWDJQU3ovTkJGN2c1Q0RDUXEySzBxb3F4ZTdG?=
 =?utf-8?B?RG0zeUxwaXQ1SEFNTVBZeDVQWkxyUmFSMzZqRFFKZFBjNjJtYVJMUUtUOGFD?=
 =?utf-8?B?ZnlXaVBwQTNKZFNadHR1N2gvaEdscUltYUNUQTBXU0tNa3ZiVnRNeWRKMktZ?=
 =?utf-8?B?SHgwTTJObWVoK2RSY2dOSG1mOVdmd0J2M0IyTk01VUMyaWlXQlhnNjJGL1Ra?=
 =?utf-8?B?ZnpJTVdOU3RwZFVxK1pUbWtsa0QzbWdVTUJOa3oxMkFOd3ZPVnYwaUFqYTlx?=
 =?utf-8?B?VGZnSUdlVS82bkRLNTJWRGZXRytWVytOUk5iRUFjNkU4MjZWTy85RjFyYnl1?=
 =?utf-8?B?dFlPcE9OYmI2MnpzTkhETDhwRHozbDBjRmJFTzZCeUhhL2FKLzN5WXphYnpX?=
 =?utf-8?B?cm5MeTlRWmZDOW04RlpYZEs3K2NGRmpUdDJscFNFRmxKV056cFovZjZQcHp2?=
 =?utf-8?B?bjJORFJzTGNYVHBBbjB3MlArRkZGbFNyc0RSWVcxdFdIQjVzczhFcFJXaUhm?=
 =?utf-8?B?S3dCTURwWjhJUlZCSlJ1UzNCS1RNckEvQ1VHVTZuQm9PeFRxQlNldzBqaElw?=
 =?utf-8?B?SUJZdkJFckVzSlQzTnlpNGhpRmo1Q2M4WXRtckZkaXQraVJGY1BVVEMvbmc4?=
 =?utf-8?B?TjgrVWVSY1pyU1k3Y0NjUklmTlM3U3Frb1VMYmtKWmpTMENodDhBTnpKUGJ5?=
 =?utf-8?B?OTVJaEIwL2Zxb00zNUJJZUpGSmVFdFFYRUloSzhnUE91S0tyWXVZSzZmcVIz?=
 =?utf-8?B?MUNrSEE4d2lTVnROY1RQWjBBalE1cmxHUStrUXg1c0NtbFQ0T3p1M0d4QlYy?=
 =?utf-8?B?M2t6b3p6OS9iemsrRkhVYVJnMTYzWUpmZ1h5R1d1SlFHMllSZTF4dUFxbDcx?=
 =?utf-8?B?MTFVdVRwRHQxZzZDSnR2UmNqUzVTK2dqZnJYT2VqcHovZUtVQk5vR0JVV3lm?=
 =?utf-8?B?dTRHd093TzVxek1RNHhaTlBBWUFZTEZPbGVISkI2T0FLdnZZWlRFN3B4N05x?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe3f9fd-c296-4841-c4f2-08de1e62fca7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 01:06:03.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F41A4Y784aNIhoMJZaRm6KkZMOjDiigXOhby+k70BZcyXSDbRv2/pbtIeZqrdqRbdo2Q16rLBXCvvDw0rmxe3aaLP1GkoA+VAev6n/1oWhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8675
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> The following lockdep splat was observed while kernel auto-online a CXL
> memory region:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.17.0djtest+ #53 Tainted: G        W
> ------------------------------------------------------
> systemd-udevd/3334 is trying to acquire lock:
> ffffffff90346188 (hmem_resource_lock){+.+.}-{4:4}, at: hmem_register_resource+0x31/0x50
> 
> but task is already holding lock:
> ffffffff90338890 ((node_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x2e/0x70
> 
> which lock already depends on the new lock.
> [..]
> Chain exists of:
>   hmem_resource_lock --> mem_hotplug_lock --> (node_chain).rwsem
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   rlock((node_chain).rwsem);
>                                lock(mem_hotplug_lock);
>                                lock((node_chain).rwsem);
>   lock(hmem_resource_lock);
> 
> The lock ordering can cause potential deadlock. There are instances
> where hmem_resource_lock is taken after (node_chain).rwsem, and vice
> versa.
> 
> Split out the target update section of hmat_register_target() so that
> hmat_callback() only envokes that section instead of attempt to register

s/envokes/invokes/

> hmem devices that it does not need to.
> 
> Fixes: cf8741ac57ed ("ACPI: NUMA: HMAT: Register "soft reserved" memory as an "hmem" device")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - Fix fixes tag. (Jonathan)
> - Refactor hmat_hotplug_target(). (Jonathan)
> ---
>  drivers/acpi/numa/hmat.c | 47 ++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 1dc73d20d989..d10cbe93c3a7 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -874,10 +874,33 @@ static void hmat_register_target_devices(struct memory_target *target)
>  	}
>  }
>  
> -static void hmat_register_target(struct memory_target *target)
> +static void hmat_hotplug_target(struct memory_target *target)

Ah, this makes sense, but is quite a bit of churn with the new
indentation and new function name which is a slightly odd fit since
initial setup is not "hotplug". Is the following equivalent / easier to
follow?

Either way,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 5a36d57289b4..a1be8cf70dc4 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -878,22 +878,16 @@ static void hmat_register_target(struct memory_target *target)
 {
 	int nid = pxm_to_node(target->memory_pxm);
 
-	/*
-	 * Devices may belong to either an offline or online
-	 * node, so unconditionally add them.
-	 */
-	hmat_register_target_devices(target);
-
 	/*
 	 * Register generic port perf numbers. The nid may not be
 	 * initialized and is still NUMA_NO_NODE.
 	 */
-	mutex_lock(&target_lock);
+	guard(mutex)(&target_lock);
 	if (*(u16 *)target->gen_port_device_handle) {
 		hmat_update_generic_target(target);
 		target->registered = true;
+		return;
 	}
-	mutex_unlock(&target_lock);
 
 	/*
 	 * Skip offline nodes. This can happen when memory
@@ -905,7 +899,6 @@ static void hmat_register_target(struct memory_target *target)
 	if (nid == NUMA_NO_NODE || !node_online(nid))
 		return;
 
-	mutex_lock(&target_lock);
 	if (!target->registered) {
 		hmat_register_target_initiators(target);
 		hmat_register_target_cache(target);
@@ -913,15 +906,16 @@ static void hmat_register_target(struct memory_target *target)
 		hmat_register_target_perf(target, ACCESS_COORDINATE_CPU);
 		target->registered = true;
 	}
-	mutex_unlock(&target_lock);
 }
 
 static void hmat_register_targets(void)
 {
 	struct memory_target *target;
 
-	list_for_each_entry(target, &targets, node)
+	list_for_each_entry(target, &targets, node) {
+		hmat_register_target_devices(target);
 		hmat_register_target(target);
+	}
 }
 
 static int hmat_callback(struct notifier_block *self,

