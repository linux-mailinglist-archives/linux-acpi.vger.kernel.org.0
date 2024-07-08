Return-Path: <linux-acpi+bounces-6813-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C129C92A412
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jul 2024 15:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48F61C21B01
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jul 2024 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6A313A407;
	Mon,  8 Jul 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJsW/NXX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC6613B290;
	Mon,  8 Jul 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446691; cv=fail; b=no85oJe42lZPGh0LMYr3I8oQ/gi4Ey+qeO+X+CvkyHhmvdM8XQZGB4GuedC543Er+wA60O+TthLsGkVJBGPt9r0PKZf258CWz5fq4a7MdatVpce+2HlI6VI02QY0aUDfXcZQVkj9/BPPRdj3eUy7L+aQcqzQRH8BSeCOb14nPDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446691; c=relaxed/simple;
	bh=0Qxh5+2u+LtRdHkaz6xMPXgb02zn8aNkkQLjWO3ipeE=;
	h=Message-ID:Date:Subject:To:References:CC:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NzIQJfIf2u2jvYRBFn+tHk3F935Bcy0F80l6JPSPpLmBmup4M1uzY07KIqFrXWTI4mkGajAb3pIhOEcsNdp0A4qtCD5EVJ2hzrdpL3mXQLWI0fHzg9IydVugyKEGdixuUrA/vFLrTryk8e6/chXyZufAzXAzCsA2tJJILa79y+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJsW/NXX; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720446689; x=1751982689;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Qxh5+2u+LtRdHkaz6xMPXgb02zn8aNkkQLjWO3ipeE=;
  b=nJsW/NXX5r6OMlCfB+1PikM9AOP92bMI+9pMaGhgzB1ZtmAPfjyp3zKn
   e1+BV8Y1zoXOf7HJkrduMnGYFGvHSRsgghsOzUXcknfYPfiQiy1kRSsJq
   dGNjvlNRXePI5BCb0B71cIm/760cRENmHynOc+VzVe8+1kcFhEClsL8tD
   5LHh/qqG3jtSaDun742z/KwRCzlaO7d9tnDmnKH0uM8k1ua/+hjg1XsNy
   fcZLlgkuX8LN/Plu+tFDBHu4uMsdnCV2faXwXhplFFKxP6+7V05HK4DAX
   JEkEucY9rJ8B6U5fv2eAnbMj9BljEYb31ZtTkjEiH/AnutQveafjYPk4D
   g==;
X-CSE-ConnectionGUID: ehlk/McdQYuFnOqog3rqYw==
X-CSE-MsgGUID: 4Je5kVVrSU2ctxUoV9NQww==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17520930"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="17520930"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 06:50:52 -0700
X-CSE-ConnectionGUID: RwaVM2mKSF++5zS8kZ5yOQ==
X-CSE-MsgGUID: 86PFYAZFTWa51B9JzAyDLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="52111800"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 06:50:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 06:50:24 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 06:50:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 06:50:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 06:50:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndxY+G6q7ND86jq1qMajhTzCTmZ5U7hI+cyEuAZM5rdtVLvAEjQkRUgnPE9ObGPM8/1QbQzejQSLjqKbRzbLK1QzxJGec2i0yTdGa7JAYuzHwBpVl7KdDfnSngk1QvJbouno7Z9QXPa3jdtVzDT8oaT+iOYWWzoZZof6hWDW2GsMxBJBlK4cmryX5BUh/3MNZkAe03yx+HCtD4lBN5J/8yS1NDg+sI9fObMZBh6pBsc6pF5ECaHGdMDfQ/8cK1x5tuTusIaHOzUx0gVQX1jL6zq8M/EiNVwqSa0RSed4gwW/Ys2blKMGDHfzQJPExcwi3iSbC8g5B6i8mu9fi4oqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru9hnRCOz+6zXu5DloFMSuho/qXTfKfed9sBQ/jz93M=;
 b=E4dEq9l5zHxAJovbTQxiB9MC+JE/2cG1PLQMc+yGZJ6Nk9mRv6SRtftmX0YsoRBfStpwWzi1vBj3HM33LMkYhFaLhfmNtBEdPzZVWxaDwo6lABX6SaCjICTcXS08xNVfGFbMRuOGmtFs0NdoExZNxfdeGuJtk4e+4t38Ep6mj4k150y9yz8PrtfTKcsuRInGJ3qG6nR/y5r2Cu/g4Des5QSPkD+K3e4UdgGYbDWFZS8Tn+khhQ1xI1zzJDstV1XWs7dkRLbXg36OvR8FZNinTsRhU8ANRqHn21aT7c8vaV+PMtpUDNePs4+QKtKrrTzViaD2lvbTcitCQtedHQc5VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 13:50:22 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 13:50:22 +0000
Message-ID: <67d74985-7be5-4e29-aab2-97a08208ca3f@intel.com>
Date: Mon, 8 Jul 2024 15:50:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in 6.8 from "ACPI: OSL: Use a threaded interrupt
 handler for SCI"
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
References: <205bd84a-fe8e-4963-968e-0763285f35ba@message-id.googlemail.com>
Content-Language: en-US
CC: LKML <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <205bd84a-fe8e-4963-968e-0763285f35ba@message-id.googlemail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZRAP278CA0018.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::28) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|MW3PR11MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e4d325-68be-46ca-2e09-08dc9f54e979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2REVEtNK3VQR1NCT2cvNkxqcGlDUHZpdjQ4NkJ2S1VnRW9aNFRnLy9tVzdq?=
 =?utf-8?B?cU9TbW5sQ3ByN3BIekxZTnFNOXd1WkRyR3RzMktFU0pwQlp1L1dBMTFrN0tw?=
 =?utf-8?B?aUJEMkw2WGdDK0Q2SnpZSlNDZTJ1aFhmd09ITU04Mm51WE5sUHJnKzF1d3hi?=
 =?utf-8?B?TXJLL1V6bEtwWU52V0V6SW5wT1BKdG5NY0pKUHRBcHExMTVwSDdEYm91NWJY?=
 =?utf-8?B?bGhNZ3NoaEF0Njc4bDBPaFNVdUwwRmlwVHhGN0xJUmF3MTBoR081dkVZK0dl?=
 =?utf-8?B?TzZHcmZjSlBSUVlka082V0FraWhGS0Vua2tEMStXTWNRRHhKakxjZ3FNK0VG?=
 =?utf-8?B?ZTJEY1Z3aUdzU1hoRi8yczJoSHJrU1RwMVlUL1d4ZlJURm5SM2lRd1VQbjY2?=
 =?utf-8?B?REhRME5HMGgyRzhvZk0xbk1FaEhqZlU4VmtoV2k3clpXazRqUDJPcmNIYmZ3?=
 =?utf-8?B?WHc5ci80ZGVLTTZ3UFdJbE81cVZsbnpxUkNZUjdwdmt3d1hVbTBxU1RLRzBD?=
 =?utf-8?B?ZVh3UDV5SjlVTzNXemduS1hhWTVWMEhqandwbWxPQng2UEVmTmw4QXB1NUp0?=
 =?utf-8?B?QWFQa0RZMDBBMDYxbmVNS2gxYmNZM3djQlE1SVBKbVZSZnBhL0syOTBPSDRa?=
 =?utf-8?B?cGEwMXMxTEZsVXZsS3dpVjlISmQyY0loMjZiZVBmUjNRMW5tdGdvN3prbzFZ?=
 =?utf-8?B?eXZ6L2Y1Z1VqRnJRY0FiMkdscGgyTE5ZY3BQSVVNZE1KVzRGbFpWYzhQRTlw?=
 =?utf-8?B?RVpBNjNHN04rdW9icDFMT2NZYXJzOFNjV3hpZDdiQ3FtaEJCZXhxM0YyRHNY?=
 =?utf-8?B?Nk9sMmU3VzRLQmdLMGdKTXZHN0R1SWRkNjkxbDg1WmF6a1JPMjJ3TU5pdWVa?=
 =?utf-8?B?aDdJd0JDYWR4elZ6SjlOem9IL21nTG5EUWgvOHlxU1ZkcVJEbVdOYXFKTzBP?=
 =?utf-8?B?aGl0dXdHelRUek5OSFR5b3BpU0JKcWxyY3BOb3RUS2t3SFVTYTlLd040MFJx?=
 =?utf-8?B?c0lwYU9Fc0FlNG5ud1JWTTV3MGRTODVUeHN0VjRUUGlmOXllb01JUjAveWVC?=
 =?utf-8?B?d1R2VEJmcS9OT292SE4zZU5sVjZ6MlNLdG56SjlQa3czN2NsOXVzLzdTUXlZ?=
 =?utf-8?B?VFdMRnFWM0ZYS3ltN0U1Y1k4OXpYakV6djJpR0FsMUhacDFHbnlBVjVlTzU1?=
 =?utf-8?B?bkpnZ2h4amgxcG1wNzNyZGI1NjQzb05VZW4wY0JGQVNYRStQd0ZJSGNJenhR?=
 =?utf-8?B?SFZCZTA1WFRYWjBzQXB1VkJrNlowbDRLNVcvNWFTaXZSUXU1WVE1QWo3OXFs?=
 =?utf-8?B?MVc4dFdpcy9tR1YrYlBETEtRMHNqSzlWM1ZtQXBUUk81TGUrNEpOaWsyQzd4?=
 =?utf-8?B?TUxiR1BiQU1tT21qSlA1Tmkzbk1Hc3pvWjVnaTk5VHEzYS9OTGR3VFhIL3pj?=
 =?utf-8?B?bEdxWi9lNjVXeXcxK2xBWlErblloLzlxVms2WGRmd2tKMjZ1VnRHTEQ2Zjly?=
 =?utf-8?B?N3EyQXVPNjV6QndsQS9wcEtNTEpGbkFOazA0MUVNMXdCam1TWkxJa3NsZHM4?=
 =?utf-8?B?YlhqZmk3ZjExVjVPVTF5cGIvUDF3Wk56WmNRQzBmTkdSOVpGNFRIRisxYzNz?=
 =?utf-8?B?dXZuL2xBQWhwK29ja2VZRFBocXU3VUs2blZDTXFteFVCbmg3YnpHYlBGdlRO?=
 =?utf-8?B?SUNpS3M2RWk5MjRNR3JBL3Z5SlhpQ3loNnU2ZEQrcFpxdmlTd2t1d3BqdXIw?=
 =?utf-8?Q?MLDpfuZuB2JPBdIbfQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czNiWU5XM1JzaER3OXhSSTFZRDltNUVNRlUrWUJYTFVzRmZpMFArdFE4Vitt?=
 =?utf-8?B?eEQrYkYvQUhnNWtPelIxeEYzMEhoYjZUYVRyYnFRdTZlSXkxakYraXBoeDYz?=
 =?utf-8?B?RkZBdFRxVVdyWnZuNU1Hc1dOeUxIbGpDUE00RUtEbGFub01lMzVzd0hlS3k3?=
 =?utf-8?B?aEFBT2dOcldNeGpxNTF4SkVLU21WaGVUUlE3OTVSWGsxWmZZUXdwU3BkSGpo?=
 =?utf-8?B?QkFCSk9sL3duU1ROaEJtUW52K2Z1Z1dpZFFlQklqUUtDZ2VibGFzL2hDOXFI?=
 =?utf-8?B?cXJGdmRoYTBNMXFISS9xY09adGtZOFZaWlZKeE5DVEYvd1lXakN6ejNHWm5u?=
 =?utf-8?B?MG9RVHNMMHFFdEE3NGYzZ3YzNjRsbWZZK3RBZHY5YjRYNnB1c0J1ZzNNai9n?=
 =?utf-8?B?a2FGcDE5NHRFaXdkeGprTW0yeWxuVS92dE4yOTlGb1pNbE5rWUd1WFBKOFZy?=
 =?utf-8?B?T2VwRUVmdUpHNktYZEJHRDNxYjY5NVRydmV5UmZWSDNCeG4wK2FYd3dLdElX?=
 =?utf-8?B?R2xmMTlRRlQ3RWxEV0FqNk9zRHlaWm1yVVJBZU1GUlZjOCttVnF0YUFkRUNi?=
 =?utf-8?B?amJUaE9Sd3pOdFZSK2ZzWjVVVkhyV0tQSjhPNHVBNTlpNE13M3dBeHdRbm9J?=
 =?utf-8?B?L3JqVHc0Q213dy85SzNtQ2tHK0YwTHpmM3psby9QcCtOYllRVnR5RUJpTlFh?=
 =?utf-8?B?cXkxRytPcVJSdnF4V2pWalZSaldqNW9LaTN4ek1hM2dRR3BkUEI4UFJFRGZL?=
 =?utf-8?B?WnhBaFRiR1J1c2JJVUlNZjhvOUdwVVg0ZDFReVVRcmVxUXREakYxZVNJZzB1?=
 =?utf-8?B?M2VYSDc3UEsvZFdJNTZucVdRSDM3K0h1eDlFQXcxaUxFWit3ajJuVzh1T0Yz?=
 =?utf-8?B?Mm5TcjNoYlBtV25BWlBkV2F3M1pqNmFOMldEMGFXZTIyQ0tYdmZQbHl4eUVE?=
 =?utf-8?B?N1ZxTDNUdTZzM0E4bi9IQUVRKzgzb2RMMXF1d2dNZWpMU2pwMCswSjd1MTFy?=
 =?utf-8?B?VmhkUy9ydlE1VWUrY1A4MVBVWTFzeDVUZWNxL1M0NzBmQ3FHdW9IMVBtTHdO?=
 =?utf-8?B?dWdMelU4aEUxSWROUTA1L2ZLaWNCVFErQ3owT1Z5SzdLbXA5YmVnTHRtek5C?=
 =?utf-8?B?dnk2WWN5MmV5VThzQS9iUzB6cXRkUkZvVjNpQ29wbndFcVc3VzU5aDRRV0VL?=
 =?utf-8?B?Q3lTSGx0cDQvV2VyNWdwRkJqZTNQdkRTY3hmT3pvVm9tNkxZeDVKcXpFaUdi?=
 =?utf-8?B?N0txZHdCSUdZSXROeWZXa0doeEFZUDQxSk5jKythSk5KUU14ZGRpNnoxWWw5?=
 =?utf-8?B?OFIvTi9jdzU0SmRIWHM3VWFBNXU1NE01akdLNUNsZ2Z2aGVtU1AzMFJndDZo?=
 =?utf-8?B?enB6cmszQWl6N3VrdHVHbjRHQlowelZpNW5jcHFOQjE3MVdZSm5lWFBiL2FI?=
 =?utf-8?B?dHpSbjN0Ymt1WVd4L0p4U0JQZXQxWS9nUDBwN2pCYjMvaHZHMkZhY3ovc256?=
 =?utf-8?B?ZmYvOHN4YVU2WWllTXVxaEp3YU5MaGtrM2tBaHdOd3RSandLQXJ0UWc0ZjU0?=
 =?utf-8?B?eXRwbkFnL3dsUjZSblZOVk5VU1BIOVhqS3J1MzIxVCtnVGFqNFdTWVZCenhX?=
 =?utf-8?B?RXFQMHRwbTJMQWxpSDlwSXh2TnhwMHo0U2QyUU5jc1QrWFMrRDBtMUY5aW1s?=
 =?utf-8?B?Y1A4bHdjbGRXVWxIVmxJcHNWYndZUzV0N3VTQ2Y0clROcDZzYitxUkw0ZGgy?=
 =?utf-8?B?Q0ZjMm1VZ3hDUlArRTdHM0xkSmFvbWUwL3RyNU1DNTZZYWJ0SXB0VlczbEJL?=
 =?utf-8?B?dEV3b3A2Nm1Jbm15VDBNTVVUUUxSSjk3MGY0M0w4QmwvYzBYMUxZY3lNa0pS?=
 =?utf-8?B?VTc0UGlaOHlQdW85azRrU1hHTnJUM0tYU3l0UTdISnE4aExxYWhUV2ZmZzVC?=
 =?utf-8?B?RnFrRXZESjIwcXEzekFVSU9QN1RqRDlJLyt1djZPQWxnVzE1SytVWGFmYXo0?=
 =?utf-8?B?MkNiTjYxTmxmZFVzRStIYkNLN21aS2N3SnFjbXdKN2NkT0JKU1g5eHAwbEtY?=
 =?utf-8?B?OHdPMklad2RnSWdBbXJlVDZ2K0JLMjdkb2FaV0ZiM3h0bko0TWRGd1hPL1dI?=
 =?utf-8?B?WVhTazAvVjRDY21PZWlNQVAxbDFqOXhHNG5KcVN4aGJnOXpoZWxrd01qOUdx?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e4d325-68be-46ca-2e09-08dc9f54e979
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 13:50:22.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHH40o7f+2s83BDPVWekyTytTPZev0WpinGe41TOSzJkktYq13f/263yLyW4accW2aaZs319FU3eET2787lR0lZ8cIf/UIyY2iYbjImhAdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
X-OriginatorOrg: intel.com

Hi,

On 7/8/2024 10:07 AM, Stefan Seyfried wrote:
> Hi all,
>
> any kernels after 6.7 break my trusty old Toughbook CF-51 by rendering 
> many PCI devices unusable.
>
> I did first notice that i915 did no longer work and filed
> https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11437, there I 
> was pointed to commit
>
> commit 7a36b901a6eb0e9945341db71ed3c45c7721cfa9
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Mon Nov 27 20:57:43 2023 +0100
>
>     ACPI: OSL: Use a threaded interrupt handler for SCI
>
> which I verified with a week-long bisecting from 6.7 to 6.8 (just for 
> fun :-)
>
Thanks for reporting this, although it would be nice to put linux-acpi 
on the CC.


> Just reverting this commit top of 6.10-rc5 (sorry, this machine is not 
> very powerful so I did not try the latest git master) makes everything 
> work fine again.
>
> I get these messages in dmesg when running the broken kernels:
>
> [  T308] genirq: Flags mismatch irq 9. 00000080 (yenta) vs. 00002080 
> (acpi)
> [  T305] genirq: Flags mismatch irq 9. 00000080 (uhci_hcd:usb1) vs. 
> 00002080 (acpi)
> [  T305] genirq: Flags mismatch irq 9. 00000080 (uhci_hcd:usb1) vs. 
> 00002080 (acpi)
> [   T46] genirq: Flags mismatch irq 9. 00000080 (ehci_hcd:usb1) vs. 
> 00002080 (acpi)
> [  T312] genirq: Flags mismatch irq 9. 00000080 (firewire_ohci) vs. 
> 00002080 (acpi)
> [  T305] genirq: Flags mismatch irq 9. 00000080 (uhci_hcd:usb1) vs. 
> 00002080 (acpi)
> [  T308] genirq: Flags mismatch irq 9. 00000080 (yenta) vs. 00002080 
> (acpi)
> [  T592] genirq: Flags mismatch irq 9. 00000080 (snd_intel8x0) vs. 
> 00002080 (acpi)
> [  T581] genirq: Flags mismatch irq 9. 00000080 (i915) vs. 00002080 
> (acpi)
> [  T874] genirq: Flags mismatch irq 9. 00000080 (enp2s1) vs. 00002080 
> (acpi)
>
> These are not present with that commit reverted.
>
So all of the drivers above attempt to share the IRQ with the SCI and 
they don't use IRQF_ONESHOT and because they all are threaded, there is 
a flags conflict.

They all need to be made pass IRQF_COND_ONESHOT when requesting 
interrupts and it will all work again.

I'll send you a patch for this (hopefully later today), but I guess it 
will take a while until it gets absorbed.

Thanks!



