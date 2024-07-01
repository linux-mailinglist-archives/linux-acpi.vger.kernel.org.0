Return-Path: <linux-acpi+bounces-6722-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F12C891EB31
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 00:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E441F226D4
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 22:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7471717109D;
	Mon,  1 Jul 2024 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFl5Z1Zh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746F86131;
	Mon,  1 Jul 2024 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719874491; cv=fail; b=pCQDltmAnEoKpE4ueVsbghg45DWVeUrMQEKuYNRUdM+GWSo+oCojjZ/1Td2rkv+Fnz2govCaNuV+Q2dMk700/fuAKMfFUgBmWoswz+hC/l/ie8+tTpehJzuK7a44OQyvl9hg7H21OyREc8cdfWm7zs3tvUbcg0WUlT2Zd0btfLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719874491; c=relaxed/simple;
	bh=DB6OX4p7GAbBQ6LYeZrnS7c88h3zqostNR9Xqttxzdk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=g3EnnK5qL4W2wlBQvEf/J81Csrc9FQ678H49irIh7nHcTxgMSFs5u6l5YTPEA4uHs+wzuuWiLIhuRLsMbGWVW+epgc1J5dIJSkUtPZPJSD8n5nE54H3gelspftZcg1KsdZkveh6Vhl5pfcflKhHXQTzApfmJ3AbyHj1NyDzFHR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFl5Z1Zh; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719874489; x=1751410489;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DB6OX4p7GAbBQ6LYeZrnS7c88h3zqostNR9Xqttxzdk=;
  b=gFl5Z1ZhcxH16QQVUbm79C60+4W3tq+vaJhJWngX52GcW1uuEu8iv2Bt
   ysvnZzjYsDtIokjVe5rEqDGTNHpPrG1cWSxlnfKAzfO8T3xCdRV3CSavs
   30vx2OmYQrXeNIPPvaoVBPh2bf9wxJGdgw63MEql/7ebyuxfIveagS9BA
   +M/fQUR4nXglwwDifBg+I+RAQOlJSmc3NMoAGGfkZFseQMtgvZ8g2z7Sf
   V1O45bSPLLkgheB2sXWuR8cpTWS8OohhQ25WYPQ3NBoKYaIijFM75nyLK
   uGElvEQL2iORJK/42VdCbIFjrHUmjGI4mcIO1bWnWtUIH5xM1m4ZH13X2
   g==;
X-CSE-ConnectionGUID: xOgzs3CQRaiNtHF7LtWQTQ==
X-CSE-MsgGUID: ODTFPz/VSTOu2kxXmsSy3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="27707563"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="27707563"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 15:54:48 -0700
X-CSE-ConnectionGUID: gPklWhAaSLStWid9EmkT8Q==
X-CSE-MsgGUID: IWR4ejklT2uXL2NJSuu5jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="45477108"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 15:54:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 15:54:48 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 15:54:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 15:54:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 15:54:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C19+3B2TNJSnCMcLrhCFIyFs4M8ub6l6elPOPTIctpeyPtYl/BmXgRoOUg7V8HIetMGvnnt08IPO7y6Yy6V/noKGQytTPA4SbKJgI7Dryddo5/SacmxzFuF45Ef3s0O5zSfG5Fsw74u2a0QobP33R7w9RmaZLY86GJwkYndKfHhe6TJhhEsSmWTIfFpAlArphvN9I6Aesc4eVD04bl4cGoQJzaMLnLmB1JM9JSFQlL1BS8u1ONe4wc18ktgXAlYqLcYcQ/L5x9SKzR7Yq1riQ4ddfKmHtrjFj23X8L0tKDHGb/ZvxZw4B7KUIk02QcMTwnV11WDVwJDMXfak8YBDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVrg4gARuPQCOwi9r2BCUfjwJ+iMTaYLSVFB2ux6Tb4=;
 b=B4i/qnkGSbe5dL+c40B6fKvFjj7ZJPMG2/c8/xG2tDXeW+/VHctwtIsjC5eAbnnChu3uFFSsNOeRJq3OOUsSUqHIk/6h+Hacg9cLmU2dPl8aRuIuT3Jzzep7L58FMpl2e9Chr22g39CMWmt1ZMwu+XuyE5UlyI5blQ0yBnYIP8eVSXLJBPq4Uf6+oNZ9Hs85YtVoVd080/PVTmjJTkXu9sEhFC0/lLaZbIVSYn5HMv5n0Ro+yhM3Dsbcy8ouYDU4G8WgXOXOOPPeRBSi7oV2cQBcbGI9RccqbGDIhEonFdEahcTf2vG9V6K/vXvmGoECsCwEYPz1TNzFH9yUgm4naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6927.namprd11.prod.outlook.com (2603:10b6:510:225::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 22:54:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 22:54:43 +0000
Date: Mon, 1 Jul 2024 15:54:41 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <mahesh.natu@intel.com>, <rafael@kernel.org>,
	<Jonathan.Cameron@huawei.com>
Subject: [ACPI Code First ECN v4] "Extended-linear" addressing for
 direct-mapped memory-side caches
Message-ID: <668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:303:8c::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 529eff4d-4405-497a-ef95-08dc9a20cc3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q47bNxelcwoMkCWYpAwLWlrO2OOOOYI7an5KFkODac+g9KkkNY/D+g/Zamwt?=
 =?us-ascii?Q?smbWsqinqvixyTY8c3w71xSF/RF6ljsmaRxVFD/9zZvASH7Ft6d3O7a7imjQ?=
 =?us-ascii?Q?Ku1HcsBLm6NR8HUPliC0seS9nAqAjs7Vm6VlYWGvpJU/mSsHrLWQkK1Aams3?=
 =?us-ascii?Q?KAB5Zy/5v+oH/cLrqAH/+2a1EtDwe/y6d5gpirUJba1vBTYScX1GbYeYMPX+?=
 =?us-ascii?Q?iT4YJwEKDThDr2DipPtsIVVruhRv0wUMBE+WvdqQ1B3t8EB33auoo4xx8fD2?=
 =?us-ascii?Q?dUQ3NEk5MdQx7v3ckKZUs0rFZECty0/Cd3Wj782kZIxx2j15cDv+qe8RWWmZ?=
 =?us-ascii?Q?NC58vyYtsRLgGTA1uxJ4hIvz5tx+/VQsejJkKS3JCflVIE3OVKffKRnrqyEK?=
 =?us-ascii?Q?pHMBv13pydWfAqPff3hFwnCU6HpAWLAR5tN6VTqOE3YZtSxmk0aXvqyCUoFg?=
 =?us-ascii?Q?U0QSfYqmgGipjJYZIsBFuouNJI/AMPLW6j0+BraYLDhZCVIZal7UL7YLWwR5?=
 =?us-ascii?Q?hKzLrLLQrUREoyV5ja1XhhWYwF7Wt6CGWoWv7IpNK0v1GJYaBYGI/tmohcb3?=
 =?us-ascii?Q?6BZ/hSUU5wmVQdCI2JZgyZC34LTvBEQ020q9MZj55GdqL02hlZkVj4XBkMpF?=
 =?us-ascii?Q?az/ZxlIPbA4+sie7oePdG+C5y2XejHwN9iE+WlI869AK3jsEdYLFMrjRxZb/?=
 =?us-ascii?Q?5Sx6BwEpuUIkHmkN3xmpI5RjlN2rNJwSVgbJHy9DlgB301TpXLvHQc9Cb/GW?=
 =?us-ascii?Q?RDx9i1eazYlRt8DqwTbZbqY2VKJYbccAnWh6fcPmaBzv95zXl7zR1NaAqOFL?=
 =?us-ascii?Q?NcoS6vMyOZNKAfuq6QblgR1NFzCOnkpfF8LDTwry4MCx6SvBjsPsmPodyQ3z?=
 =?us-ascii?Q?f+xJ1O/BsrK10K8Yj+miX1p8tALuZ4iVx6BOoTbXYrdbyjGLdhQydNyNmTZT?=
 =?us-ascii?Q?nhMICq9lFnskzg54hZ3TOXIX1S3hhm70apUO6p8GhgQeetJs1qD1JKYkk8mD?=
 =?us-ascii?Q?HEUVs8yAPpmq160lTPbnTaN4gHnHs7fojPwOAQ0cb+Uequo+69fRblvm7lFT?=
 =?us-ascii?Q?lZ+XVR419rVk5asWIslJJmf97Q7yKmSiW4wmEkuZSSbR+6rUuS4AHw6Zkmxv?=
 =?us-ascii?Q?5PLpjDpwH7utxMmPmsnv5LcprBgsHOEnZbj2KKjmZAw1T3cYAp0RUbBuN0/u?=
 =?us-ascii?Q?QyRFnisU4xlttHpxtds22iDT+tq08Mm44HKIMZDUo38UE3UIxIPWuiNj5dlq?=
 =?us-ascii?Q?pp9Cv6PMtYoR4AXS0Lhjf39uo67oSrGKBBnaHnI3kvrjfhneTAaqrXuPAff2?=
 =?us-ascii?Q?VV4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e16kfweJDklIm9KA05Fc7AHCG9ddwWTUurMUyl1iXcKsw2bmwbdkDBoH9pAG?=
 =?us-ascii?Q?U8yHNfSPqdO4Yzmqp3SEwqsN0KJ5MEJlrGniDCppVgx32F1EtX7Yi675DuX3?=
 =?us-ascii?Q?uyL6i6SDsC5BajjvNgRXFuEQPp3vwDSIuAor4G3e3BE7tbHFWEjfBLFrtCSG?=
 =?us-ascii?Q?GC2zsv+UDeiCiGk7ScGmp72Y63HdipQqOyhuvrgEYaEBrzq878w/lfOOpFpn?=
 =?us-ascii?Q?qq7UgbfHzM7Jw3YolGt3I1FVIkXU2lJmomGs9ZhSSCvlX54wfb2KaMBuybhf?=
 =?us-ascii?Q?vSYrYVqjM4jvz93uxR93Vj5bUu/a9Vsp9z7bKjb1Gs/CV688UHY3KuiRNxTy?=
 =?us-ascii?Q?+Uc/Wgh3DR42AsCaLwXJp8bES9f37bQrcrrfd8b8CcKWWXTU8io459jPx0av?=
 =?us-ascii?Q?CueQEOw3/aFtWJHG7jRr22DVYMow/XkOfS7Lf9qoZD+seVTj2N2wYeHw3PC4?=
 =?us-ascii?Q?82cfFgnLf5tTBLwT9qSPP/FihA2UqoAh2NMccohwRjGgA0h/7JT9dKFqNDZq?=
 =?us-ascii?Q?GNxA1F08gGZm61lBHapchg0X/Np1U+pzXnUyB7LIPFuMWoRqYf2Tl/9R3GFK?=
 =?us-ascii?Q?sqFKJCADjYlgOC6iuMwZZRLfo+rnBc15kFtvXoCO1XTz8KG1qcr+fZQjCZUP?=
 =?us-ascii?Q?u+u10C7WyrC5HNPGiODDaJdtpkO69AcJukv9qxCzFnlDMLoMtfEDGBJ8dCAu?=
 =?us-ascii?Q?FWheQD8zfWHTZlHRwUMkHrk+HM/ba6T6AgbdbcjwtwPHHLQy5Enpe+RGx+2B?=
 =?us-ascii?Q?IqHNSIv/mTQwNabVvSyYYFQxFmRYPP93+Ew1QTnvevX0s0xtHPozHUaqeGcj?=
 =?us-ascii?Q?bL5XvzlHLVPlZ3Q6EUugniutRo+6IzhEt4TrjQVOicIDN9FfHXHBax/7QzM2?=
 =?us-ascii?Q?ruOGtSSQq9MnCkflvEtg2zoEotRv1DbS1EgBSNqqXO8YvI39wSORlx+tQvnw?=
 =?us-ascii?Q?SaxDWpPgIPtapxQpXSrPF6PXJ2Lol0xpcnuWVqeC2jQuwCM7X4aAqc6LeJ54?=
 =?us-ascii?Q?m8h3OzzSwt0ycRtPflJpVgwNf5C7SOyH1ekIcVGm3H4jYiaXppPT/4TQuaDg?=
 =?us-ascii?Q?e7S71txhlRQClcUtlLHtgKpR+FLXHGx4FHbl6AL25FVCCNhtm6wKLkc88RJH?=
 =?us-ascii?Q?zr5Y6f3PfWT5hCPP6W4euLISMHtUywd27EL1IhZzYmvs3m/z72OwnFqXEVzn?=
 =?us-ascii?Q?YlsUYb91VlpV/TizI+p53Yuz2dC1JNTkGoSz9JAyYewMYIenwtTyJsMKic6Z?=
 =?us-ascii?Q?pZ/RYf3LeTNEicOywL8f2W2T+a1HycOO13DDFCSmIEViv35G5ZV4rwl3/Kus?=
 =?us-ascii?Q?xc8Q1HUc0WXUdcma/mXbQjR+VqVxBytCeFQFQ9orj9RXMgdNDWIPZSewxcVi?=
 =?us-ascii?Q?QHPCz6mtlVxdzfTKx07K8vYJb0xsA5PH8d2BSSwyA4Ac3tQnB7FIBlFoANZy?=
 =?us-ascii?Q?Ww8cuW8pOMOvyi61VQdlFgoPa+DmVy5CprMnvK/ZReAu8xmf637wKUE4OBQ7?=
 =?us-ascii?Q?4ycZ36jeO9AggWea5Ce62yb5Skb97HELwuGl/HCOWeaqtZ5wpu4oF5da8usZ?=
 =?us-ascii?Q?0Fqi0m+hNQ3DrGgyvMN2OijVmpPaiH4qsWskQbFeg2pS+DtHeLgQTe9lIWX3?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 529eff4d-4405-497a-ef95-08dc9a20cc3a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 22:54:43.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDjqf/5YAsVS0lSeHKub4RApYMF2EEmQk7Qy4yt2/okzmZaGs0egp4mgBX+ar0Mf2P1PRR/9f4Ad56tvEVj/Z5O0qSssgLnBG/n5CtxMJpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6927
X-OriginatorOrg: intel.com

# Title: "Extended-linear" addressing for direct-mapped memory-side caches

# Status: v4

# Document: ACPI Specification 6.6

# License
SPDX-License Identifier: CC-BY-4.0

# Submitter:
* Sponsor: Dan Williams, Intel
* Creators/Contributors:
    * Andy Rudoff, retired
    * Mahesh Natu, Intel
    * Ishwar Agarwal, Intel

# Changelog
* v4: Drop "improved cache utilization" claim (Jonathan)
* v4: Clarify SPA vs HPA terminology
* v4: Clarify possibility and difficulty of multiple CPER records to
  communicate aliases (Jonathan)
* v4: Clarify that N is expected to be an integer ration of "near" to
  "far" memory. (Jonathan)
* v3: Replace "Inclusive Linear" with "Extended-linear" term, and
  clarify the SPA vs HPA behavior of this cache addressing mode.
  (Jonathan)
* v2: Clarify the "Inclusive" term as "including the capacity of the cache
  in the SRAT range length"
* v2: Clarify that 0 is an undeclared / transparent Address Mode, and
  that Address Mode values other than 1 are Reserved.

v3: http://lore.kernel.org/6650e4f835a0e_195e294a8@dwillia2-mobl3.amr.corp.intel.com.notmuch
v2: http://lore.kernel.org/663ea70884cfd_db82d29414@dwillia2-xfh.jf.intel.com.notmuch

# Summary of the Change
Recall that one of the modes available with persistent memory (PMEM) was a
direct-mapped memory-side cache where DDR-memory transparently cached
PMEM. This article has more details:

https://thessdguy.com/intels-optane-two-confusing-modes-part-2-memory-mode/

...but the main takeaway of that article that is relevant for this ECN
is:

    "[PMEM] is paired with a DRAM that behaves as a cache, and,
     like a cache, it is invisible to the user. [..] A typical system
     might combine a 64GB DRAM DIMM with a 512GB Optane DIMM, but the
     total memory size will appear to the software as only 512GB."

Instead, this new "extended-linear" direct-mapped memory-side cache
addressing mode would make the memory-size that appears to software in
the above example as 576GB, an increase of addressable capacity.

A primary motivation for updating HMAT to explicitly enumerate this
addressing mode is due to the OSPM's increased role for RAS and
address-translation with CXL topologies. With CXL and OS native RAS
flows OSPM is responsible for understanding and navigating the
relationship between System-Physical-Address (SPA) ranges published
ACPI.SRAT.MemoryAffinity, Host-Physical-Address ranges (HPA) published
in the ACPI.CEDT.CFMWS, and HPAs programmed in CXL memory expander
endpoints.

Enable an OSPM to enumerate that the capacity for a memory-side cache
extends an SRAT range. Typically the "Memory Side Cache Size" enumerated
in the HMAT is "excluded" from the SRAT range length because it is a
transparent cache of the SRAT capacity. I.e. typical systems present 1:1
SPA:HPA, extended-linear memory-side-cache systems alias multiple SPAs
to a single CXL HPA.  The enumeration of this addressing mode enables
OSPM-memory-RAS (Reliability, Availability, and Serviceability) flows.

# Benefits of the Change
Without this change an OSPM that encounters a memory-side cache
configuration of DDR fronting CXL may not understand that an SRAT range
extended by cache capacity should be maintained as one contiguous SPA
range even though the CXL HPA decode configuration only maps a subset of
the SRAT SPA range. In other words the memory-side-cache dynamically
maps access to that SPA range to either a CXL or DDR HPA.

Without this change the only way for system software to become aware of
the fact that one memory poison event implicates multiple address
locations would be for multiple error records (CPER) to be emitted
per-poison consumption event. That may surprise existing OSPM
implementations.

With this change, the OSPM can enumerate aliases and take actions like
quarantine / offline all the impacted aliased pages to prevent further
consumption of poison, or run repair operations on all the affected
targets. The OSPM is enabled to identify the HPA associated with a given
CXL endpoint DPA event, and understand how SPAs map to CXL HPAs.

# Impact of the Change
The proposed "Address Mode" field consumes the 2 Reserved bytes
following the "Cache Attributes" field in the "Memory Side Cache
Information Structure". The default reserved value of 0 indicates the
status quo of an undeclared addressing mode where the expectation is
that it is safe to assume the cache-capacity is transparent to the SRAT
range capacity. An OSPM that knows about new values can consider SPA to
HPA relationships according to the address-layout definition proposed
below. A legacy OSPM will ignore it as a Reserved field.

# References
* Compute Express Link Specification v3.1,
<https://www.computeexpresslink.org/>

# Detailed Description of the Change

* Section Table 5.149: Memory Side Cache Information Structure redefine
  the 2 Reserved bytes starting at offset 28 as "Address Mode":

    * 0 - Reserved (Unknown Address Mode)
    * 1 - Extended-linear (N direct-map aliases linearly mapped)
    * 2..65535 - Reserved (Unknown Address Mode)

* Extend the implementation note after Table 5.149 to explain how to
  interpret the "Extended-linear" mode.

  * When Address Mode is 1 'Extended-Linear' it indicates that the
    associated address range (SRAT.MemoryAffinityStructure.Length) is
    comprised of the backing store capacity extended by the cache
    capacity. It is arranged such that there are N directly addressable
    aliases of a given cacheline where N is an integer ratio of target memory
    proximity domain size and the memory side cache size. Where the N
    aliased addresses for a given cacheline all share the same result
    for the operation 'address modulo cache size'. This setting is only
    allowed when 'Cache Associativity' is 'Direct Map'."

