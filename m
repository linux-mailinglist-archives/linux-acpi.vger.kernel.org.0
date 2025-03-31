Return-Path: <linux-acpi+bounces-12545-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA93A75D87
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 03:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEECE7A3239
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 01:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E88134AC;
	Mon, 31 Mar 2025 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHBsMMm8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AA23DE;
	Mon, 31 Mar 2025 01:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743383373; cv=fail; b=ovbvwMw7ag5r4EyFQhnPIAbSGUzrcbL4Aib6YZ8mLZ2np8CawpEYg/8VjnEP5jxIMIbw+p/f+7VHhwwjWpvRc8RRKjS6kB9EDXgpoOwBMoz58b1qoyiNJR5aYNB5n+8y1Cn1nqrrwdlcjhuUEt0CEsw5DiPTgA29mNAIpZe9qnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743383373; c=relaxed/simple;
	bh=kD3DPgeETQ4bckSVLDfb+1UbtT6QTh4sB0UkFGHZzcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tZ+n4HEDfOKeYydRCxuSy8z0ZD9bi+S2WRx3HFojGVMStqAxzIXEBsLOY6ZQmNfSol2jItRgX99HJUVhC0IyC4T35n2UuMXSn9/OH2OTPhbOR7K74J+sdslU+tqlaU4Xf68l3coT3ye2Fzka2FTXPQv6i6KPCt9so1GqYlZcnT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHBsMMm8; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743383372; x=1774919372;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kD3DPgeETQ4bckSVLDfb+1UbtT6QTh4sB0UkFGHZzcw=;
  b=QHBsMMm8Re0z4a6CP9QIocN/XQMzXo5E/udJKrLVYRQ4SEFyixETET1W
   twWVW4hTV8PKhkQh/EJQutuPNUsgWJq0Rt6JvE5eCBM2WlD1mTHxfPDEe
   2Fivku8eksEuw/RBjGFoxTcniFbwdwRSwqHxIkUne9UXqGbNxuBJTAXfh
   t/NTKSWS47Fp4HZvMHhXXSr92FJq+paILJQC1K2HPGBoSMlL3sZWGB0gW
   HfOos/uPyg+CxcapimTkF5weKo3pRWJveoMShdoK1VfMA5k2niEZKm5Rc
   W4aRG5I4zcofvfApekJ+MsOiyfVh3bLi0ZzCb7/6CXUoYPn2F6gv8p/J/
   g==;
X-CSE-ConnectionGUID: 0J2PEwWxQuqG8L/BJ7N/pw==
X-CSE-MsgGUID: JK34iXlvRe6DyJhXYKSyyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="44575135"
X-IronPort-AV: E=Sophos;i="6.14,289,1736841600"; 
   d="scan'208";a="44575135"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 18:09:31 -0700
X-CSE-ConnectionGUID: yFLwG09JRXGEdNyJY7fIrg==
X-CSE-MsgGUID: 1H4Z7yLGSZeyQsxuy9bEcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,289,1736841600"; 
   d="scan'208";a="130081068"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 18:09:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 30 Mar 2025 18:09:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 30 Mar 2025 18:09:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 30 Mar 2025 18:09:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DraQnVV/XENq4FsQR03zsdEJeVWnyQz2Nuzem5GOwhsNYxMCymMg1YFfeJPGuD3ef/pF/FoMTTLD4TJ4U+7I8lHNEfot1go3//OKRP5R2ZGf1ijtb62o8RdSyMZGXCjReGj/0bOKZp179gK4Hw4fEBi87GFUf6pZz9qCxGMllucUA/P89UpEOjkO4T0HtmyFds3Ppp2SekporAh2F6q3R866LnlzvZDWIK1g6h1rkpbOG9KihIWo4YcThwo63rFKHQ1N9UwoybU42+jBzYH3yXX1hYeB5ZKmviMFH5t/MP5MviPhKKBAHlEW6DTavIM65ydFQBaTVn2yrvfD2zBcIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD3DPgeETQ4bckSVLDfb+1UbtT6QTh4sB0UkFGHZzcw=;
 b=cKr0Hj3F+VpMp3gm1tHx5G6ts/DdTgTrMteKyLD2mYyyk+5L4W6EmeY5aYzTMo6umlpS+bzYrRa7fHWTmqllldEITTzuvjNb4aWY2NDfwcNUUQRqNgE0jRDF8nSY31jv4bfZsvXDL5m3D4sW+atKa4V+sH0sGvZpda5Yrw+jV594+GmXkfO2GHRpN8dXTM6+HE50jLP1AJj6WgsAlwiOnDVQx/bqmf80p+3u8hm+CzqnuNOa/xz9kMrVUxO/ozbYLWvaqAURGALz8J0w/UkVEqwYwIJ4JSmOcjpyaFzNdkMXftjpllHGRKL/pXdtDn8hKvDOFXtf+nunLDTNChHEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB5938.namprd11.prod.outlook.com (2603:10b6:a03:42d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 01:08:59 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%3]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 01:08:59 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "ggherdovich@suse.cz" <ggherdovich@suse.cz>, "rafael@kernel.org"
	<rafael@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] ACPI: processor: idle: Return an error if both
 P_LVL{2,3} idle states are invalid
Thread-Topic: [PATCH 1/2] ACPI: processor: idle: Return an error if both
 P_LVL{2,3} idle states are invalid
Thread-Index: AQHbn+4SAFa1wDGJCUy7xEETyC9S2LOMcxiA
Date: Mon, 31 Mar 2025 01:08:59 +0000
Message-ID: <55bc62e588f526ae964533cf2af612a4beea5d32.camel@intel.com>
References: <20250328143040.9348-1-ggherdovich@suse.cz>
In-Reply-To: <20250328143040.9348-1-ggherdovich@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB5938:EE_
x-ms-office365-filtering-correlation-id: c0944153-a3e5-4d12-2451-08dd6ff09e28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WWRKbmZ1SVlWQ0FwQ3VPUDdMU2tUSXhUY2VHdWNZK2hpVzMzcEFtYW5pYms1?=
 =?utf-8?B?RHBGZjZod1NwWC9tSVh4M0kwYnVCaHhQai81YmdtSUFKLzE2ZWZ0TEM2WEl1?=
 =?utf-8?B?alJpQy9Nb283NzJPcFF1b0hxQ0tFeVRHbG9vNm1KbCtjSFFkWGZ5bVpGZ0ly?=
 =?utf-8?B?eTVvdlh0M3JzNmd0V2RjOU9ZZWRIZVdsNlRFdHlwSXFLeUNZa1ZoMFg1ak1y?=
 =?utf-8?B?ajNoemc5MzlnQjFYM3FyWCs4b0RiSEs1aXl3b3BUTUxYbU1MWEQxdHcxanlS?=
 =?utf-8?B?a2JFbU5uN1pzbEd1R1FYWE9acUZsazdKK2lSUGVPTzd0czlKcis4L05paFRK?=
 =?utf-8?B?RTkzNHBBNjFOT3lsSGRvNUNYNkQrOStneFNjbGJjOVNRblRwOXpWWWhKUzJp?=
 =?utf-8?B?eS91L0VFNUJVWU92UVlQWVFWcVZ0NktNY3A0RHRpaktNaFZ1eUlERXh1QStB?=
 =?utf-8?B?MXBvR0JPMGVqVThjcDJvbllQbjhsSHd5ZmtIZklZc2RIbGtSbWlNcWVBajhx?=
 =?utf-8?B?aEE3TjduRXRMMmVQcXpjNXdNZDBvZ0E5VEk1dGFpU3hVeW5BcmhmaGtSRFRv?=
 =?utf-8?B?WWpWa094QTloTVpZT2w4V3lRWTludGcwU1h4MDVVSXNmcGluNE1ZQmIrRXNr?=
 =?utf-8?B?di9XdmpUbHFXc2xhWENUd0EvTG0zemRYMWIzTzdUb1d6Y3RxVW5NemNtZFdI?=
 =?utf-8?B?a1pSeDhmMklJNHlxK1lvQjM2WlFxVHRWTi96ekI2b3hibFY1cWZpK2pnK1Fi?=
 =?utf-8?B?UnI3NXBhSTFXazY4djBxWDhNQnZ2Mkk5UWt4OFVhb3ZoOExlU1dQOUZ4b1BO?=
 =?utf-8?B?WjlmZDhCN0UxUjFPbUFHYXo1YkJ1NDdKNnR0QThLRXVYSjM3Ny84YlN0SG0z?=
 =?utf-8?B?Zi9ldzdGR2l1VEc3Tm50a0xpWmQyRGJ6MWI0ZW8xdlRRZUQrMXZWYnBxTVJh?=
 =?utf-8?B?dW5QNVFxMHZSZWRicXpadEUzMXp5T0UxR0dpbDFqK1d2TjgvcnduV3JBV1ln?=
 =?utf-8?B?TDNuajJxdHNRemtxcmdsRWNDZ3RWYkRtZ2dKUHpKZjRPTlFTNGxidWpLWDVW?=
 =?utf-8?B?SnpEV280aVpIazZFbGl1MFdDL2FWd2tsVDIweTBBTi9mU0VSZDM2ODRoMDV2?=
 =?utf-8?B?TDBIRHpQeGZVbk1qbVBXMERUK2NSZTQvcFhOS2s0SWtlakNGOWhET3NVaTR0?=
 =?utf-8?B?dmlwRWZ2RThLNy9YNnVubU01ZjBhSWlubXE3aXd2b1h2WmRqalBsTlMxNHli?=
 =?utf-8?B?UWRybUcxMHlQeklJWHkxb3pMdTdmdlFqWXl1bXA2b0x6R0xZNHlIOFZNcGMz?=
 =?utf-8?B?RHhrNUU4ZUZ0VU03SU4vSkpadjhJYlByYjI1K3pubmQ5ZGZXNkFicC9oclFJ?=
 =?utf-8?B?MjZWOG5CN3cyNXhYODZsQ1NQdklucTdkUnU4eDRyM0pJTzhweHZkVitNYlAz?=
 =?utf-8?B?ZjZNTC9HTjV1dkZWL3N2UFYxOXYwVE1PYXFoRG1IQTJsU1VBUFMxcytUR3Rv?=
 =?utf-8?B?QVFpWFVzMEUvQ3hKSCt2ZVZ3eGVtaTE3cFdtM3dlV1p0Yi9wRHA2Y1BKQmg2?=
 =?utf-8?B?QlVxaTl4UzBCa2FnZkxqL0ltQkN3SkNseXhORE5WRUtHc3FMNmdwVk9Ua1Mr?=
 =?utf-8?B?T3AwdVU1UGlaT25EYTM5OHNxTU9lQW1JV1Y1Q1lQUTNGenlhck1ZR2VHZnB5?=
 =?utf-8?B?ZHpGSVROWDlWN0R1bU5BakRlbHUzVk9rQVZrTDRSUUtsTjVMV2grMXFncnNn?=
 =?utf-8?B?UnRVMWpSd052bGtXYU9FL0ZmV3d6WWNZcXlhL2dlZjM4cDM3NFZSQ0FTWHVj?=
 =?utf-8?B?UzI1VUZYRUxoNEMrQURONFJpUCtBL215dDQ3RitnbVpSYnhid25OUkE3U3NC?=
 =?utf-8?B?aXNkZmNSeHg2UHc5YkpCOG5VTEtGV3VzRkhmQjZtRklFQ2xPandVcm8wUkxS?=
 =?utf-8?Q?99HkdvAOS1RydHhG7O+UL+/WGe9bb7zr?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnllVnkwU1hjejdMSytVNU9wQmRkd1NBbGxZdjdSaDcxeWx1Y042YWs2TjFk?=
 =?utf-8?B?ZjkvMGl4VEcvenJlNU1NYTBXRnpRcThENEx4WnZTeDlxYnN3a3B1S3VSK1Zk?=
 =?utf-8?B?NUY0TVFMdE8wVXNxanlWUkZaVzJ2VEhWTExMZUdzWFpoZFFqd0RmaGRIZUNK?=
 =?utf-8?B?Z3RNQVlkZFBucjNmUG5vWnEvUkk3akptZFJLL1NqYythNkFabURwd0FoSitx?=
 =?utf-8?B?S09VRDFGcXhHUG5YMmdyM2ZLUTZGV0RaZldnN1RXM3V0dDc0Z2tKMjB3bnUx?=
 =?utf-8?B?cC93UkRma0hhZzNveWRvRTBDSmgxeDUrYUJGREpabWJuUkw0cWZRR0d3NERs?=
 =?utf-8?B?aWhhcjZMdXd5Mmp0SnBLNGIwTmhvbmc1MXgvV292eVR0WGZCa1ArOWJvVC85?=
 =?utf-8?B?YXNDSlp3aGZKUHh2L1B6cGVWWmVQaFlCTEFWUkdpejdGZjM5WUxVSFFscGtr?=
 =?utf-8?B?dnVreFY5YmFSMk15SExzSlBabmE1RWRwM0Y5RndRNFpOZVgxb043RTZ2TjFO?=
 =?utf-8?B?SE1Wb1FaVHpLalduQWZoT0s5T2pjN1ZPdDc4dTRVdVltLy9hZUFrTzV3ZjFM?=
 =?utf-8?B?OUtOS2daTlpoSEd3MDVpNVB4YVAyMmovWWtLMFUrMUZDMXkxOXhMaUZqY0Zl?=
 =?utf-8?B?VU1TdVBNL3RmbmlMU3dZTlh5OUZxYWZVQ29SbC9CeEJxQ2RlR3g0NkpHYkp5?=
 =?utf-8?B?dE9IRmxneFNnMjBFaTFzeDZHSmVkNUw0OXZ0eHdiV2ZqbkVtdVYzTkkwL3lC?=
 =?utf-8?B?SVdJcUhwdEJsUGJPdEhlN1M3dkF1SW5CcGh6TGY1QWN1LzU5OG1KOElkdzBa?=
 =?utf-8?B?V1IrVEsrRVNSblFJVlVEUlhxS25JTnZ4S1NpVkhjeC9iYlcyMXVzRHZlQktJ?=
 =?utf-8?B?WTlmQWJKQmUvQ1ZrdXlKdVBUdloyRGp5eFJWcVJZVVJ3eTc5azUvcXFXQUZR?=
 =?utf-8?B?T1pCL3ZJaTFvSHNuVFZMb1lwYVlodTBPRWJ6SnRpZXc3V1A2SUhxdVBCajYr?=
 =?utf-8?B?VHI1UlpaZ1Vtd1liNnBKU2x0ODdxNHRwMThoQjRycGdtdGJNL1ZBWis2bFIy?=
 =?utf-8?B?TE5sWVlseXpOUkRjQS90bFVBNVZMZzUrRjdycFp2OGJNSU41TnN4WWJJcmVX?=
 =?utf-8?B?WVJyajN2ckdLeWRqYjVFWVI1UnMxVkpxOSsvTUd3SDZrZVNnM3VneTYyelIr?=
 =?utf-8?B?WnpuOHgvbFlzMlBWbmY4UHoxRytyWjU0c0hMK0N5N1BJNisrQWFMakczYkp5?=
 =?utf-8?B?TmxNUXRqSEduN1B1MmpsUnl5ditHR05IQkVQbkJMRUhaUmx1bCtoRzhlMHF0?=
 =?utf-8?B?RDdwL05kbHQ3YTVBMGFMTXBuZ0xLQ3JsODRDZFNtNm5vaHVNdFVqb0wwQThS?=
 =?utf-8?B?OVZGVmNSNlVvMllmN29Wd2c0Y3VYdEFBVjVyM1JZOER4a1d3UzhacFU2ZmVm?=
 =?utf-8?B?cTkvb2c2dHBVRkF0VEhCYldPOGJzdU1MSEZEOGNHQnpDdjFrc1o4V1FyTGpj?=
 =?utf-8?B?eUxhN2ZKZDhibVhvakJraXlBU3BsOWpURXZXeFpVY3dlZ1lLaFdpNHBjN1lr?=
 =?utf-8?B?VFY1TlF3a3p1QUhxZFZPMlpIb1RCWlZnS2RJL3VLVUJ3WkRPTzA1dGtaaWZ1?=
 =?utf-8?B?OVdCQ1JFczhBcFRVVWdlVXNUcGRaWDVVNzNrS2p4cFQyS3J3N0JNS2tSbEVs?=
 =?utf-8?B?VDdlK3BGZmxZTU5DcG4vSGpNYmFBSythc0VTa1M2VmZhQkl5ZVpoZjRIZ3Nz?=
 =?utf-8?B?N3dHSFBwOVlzeVRXN2RIdjJYM0RKZzV5M1ljSGxxR20vOFdUaUtTa0tzZ1pV?=
 =?utf-8?B?NEd3VmNFS1VYRkpudEErZm1YeXZpa21mWm5xcFlHdlJjbkNuUXM4S2syanlX?=
 =?utf-8?B?THpoWVdKU1NEZ0Q3ZDVuOUpSR0cwZXY0U2hyRkJtY3czb2RkS3dEeVl4UWtX?=
 =?utf-8?B?ODRlNS9VenQvOFFRYUpNOThoZndDZktMOUpJWGxnVVpva3hNYTRIckx0dXVq?=
 =?utf-8?B?OGhTWXpUaEJEamZ6SkZ4MkxKcnEyMzd3OFVMTVdvMkhrdjZnSEN2Tm5RTXdX?=
 =?utf-8?B?RjhLWS9NbnRncEJWbUlxTDRVNExsem9VaWhRL2hVTWhnNjQxeEtuZVBIQzVt?=
 =?utf-8?B?QUNSSldNZ2ZiODlTcy9idGhJbWtOUFlxc2I0WEVGUW5xQUszQ0RQT09pZDlj?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E54EBA2B039904A9924DFE290D65427@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0944153-a3e5-4d12-2451-08dd6ff09e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 01:08:59.2113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lHMStUf9xOTOYx4gB8LQq2aHp8lhdRoFr08xIgi03pXcSJfqEzJKYuit0uthzEwWUsrOt87t4gTsudsfqO6lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5938
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTAzLTI4IGF0IDE1OjMwICswMTAwLCBHaW92YW5uaSBHaGVyZG92aWNoIHdy
b3RlOg0KPiBQcmlvciB0byBjb21taXQgNDk2MTIxYzAyMTI3ZTljNDYwYjQzNjI0NGMzODI2MGIw
NDRjYzQ1YSAoIkFDUEk6DQo+IHByb2Nlc3NvcjoNCj4gaWRsZTogQWxsb3cgcHJvYmluZyBvbiBw
bGF0Zm9ybXMgd2l0aCBvbmUgQUNQSSBDLXN0YXRlIiksIHRoZQ0KPiBhY3BpX2lkbGUNCj4gZHJp
dmVyIHdvdWxkbid0IGxvYWQgb24gc3lzdGVtcyB3aXRob3V0IGEgdmFsaWQgQy1TdGF0ZSBhdCBs
ZWFzdCBhcw0KPiBkZWVwDQo+IGFzIEMyLiBUaGUgYmVoYXZpb3Igd2FzIGRlc2lyYWJsZSBmb3Ig
Z3Vlc3RzIG9uIGh5cGVydmlzb3JzIHN1Y2ggYXMNCj4gVk1XYXJlDQo+IEVTWGksIHdoaWNoIGJ5
IGRlZmF1bHQgZG9uJ3QgaGF2ZSB0aGUgX0NTVCBBQ1BJIG1ldGhvZCwgYW5kIHNldCB0aGUNCj4g
QzIgYW5kDQo+IEMzIGxhdGVuY2llcyB0byAxMDEgYW5kIDEwMDEgbWljcm9zZWNvbmRzIHJlc3Bl
Y3RpdmVseSB2aWEgdGhlIEZBRFQsDQo+IHRvDQo+IHNpZ25pZnkgdGhleSdyZSB1bnN1cHBvcnRl
ZC4NCj4gDQo+IFNpbmNlIHRoZSBhYm92ZSBjaGFuZ2UgdGhvdWdoLCB0aGVzZSB2aXJ0dWFsaXpl
ZCBkZXBsb3ltZW50cyBlbmQgdXANCj4gbG9hZGluZw0KPiBhY3BpX2lkbGUsIGFuZCB0aHVzIGVu
dGVyaW5nIHRoZSBkZWZhdWx0IEMxIEMtU3RhdGUgc2V0IGJ5DQo+IGFjcGlfcHJvY2Vzc29yX2dl
dF9wb3dlcl9pbmZvX2RlZmF1bHQoKTsgdGhpcyBpcyB1bmRlc2lyYWJsZSBmb3IgYQ0KPiBzeXN0
ZW0NCj4gdGhhdCdzIGNvbW11bmljYXRpbmcgdG8gdGhlIE9TIGl0IGRvZXNuJ3Qgd2FudCBDLVN0
YXRlcyAobWlzc2luZw0KPiBfQ1NULCBhbmQNCj4gaW52YWxpZCBDMi9DMyBpbiBGQURUKS4NCj4g
DQo+IE1ha2UgYWNwaV9wcm9jZXNzb3JfZ2V0X3Bvd2VyX2luZm9fZmFkdCgpIHJldHVybiBFTk9E
RVYgaW4gdGhhdCBjYXNlLA0KPiBzbw0KPiB0aGF0IGFjcGlfcHJvY2Vzc29yX2dldF9jc3RhdGVf
aW5mbygpIGV4aXRzIGVhcmx5IGFuZCBkb2Vzbid0IHNldA0KPiBwci0+ZmxhZ3MucG93ZXIgPSAx
Lg0KPiANCj4gRml4ZXM6IDQ5NjEyMWMwMjEyNyAoIkFDUEk6IHByb2Nlc3NvcjogaWRsZTogQWxs
b3cgcHJvYmluZyBvbg0KPiBwbGF0Zm9ybXMgd2l0aCBvbmUgQUNQSSBDLXN0YXRlIikNCj4gU2ln
bmVkLW9mZi1ieTogR2lvdmFubmkgR2hlcmRvdmljaCA8Z2doZXJkb3ZpY2hAc3VzZS5jej4NCg0K
TEdUTS4NCg0KUmV2aWV3ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCg0K
LXJ1aQ0KPiAtLS0NCj4gwqBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYyB8IDQgKysrKw0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYw0KPiBiL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3Jf
aWRsZS5jDQo+IGluZGV4IDU4NmNjN2QxZDhhYS4uYjE4MWY3ZmMyMDkwIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYw0KPiArKysgYi9kcml2ZXJzL2FjcGkvcHJv
Y2Vzc29yX2lkbGUuYw0KPiBAQCAtMjY4LDYgKzI2OCwxMCBAQCBzdGF0aWMgaW50DQo+IGFjcGlf
cHJvY2Vzc29yX2dldF9wb3dlcl9pbmZvX2ZhZHQoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcikN
Cj4gwqAJCQkgQUNQSV9DWF9ERVNDX0xFTiwgIkFDUEkgUF9MVkwzIElPUE9SVA0KPiAweCV4IiwN
Cj4gwqAJCQkgcHItPnBvd2VyLnN0YXRlc1tBQ1BJX1NUQVRFX0MzXS5hZGRyZXNzKTsNCj4gwqAN
Cj4gKwlpZiAoIXByLT5wb3dlci5zdGF0ZXNbQUNQSV9TVEFURV9DMl0uYWRkcmVzcyAmJg0KPiAr
CcKgwqDCoCAhcHItPnBvd2VyLnN0YXRlc1tBQ1BJX1NUQVRFX0MzXS5hZGRyZXNzKQ0KPiArCQly
ZXR1cm4gLUVOT0RFVjsNCj4gKw0KPiDCoAlyZXR1cm4gMDsNCj4gwqB9DQo+IMKgDQoNCg==

