Return-Path: <linux-acpi+bounces-21386-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKuYMR3yqGnDzQAAu9opvQ
	(envelope-from <linux-acpi+bounces-21386-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 04:01:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 351EA20A64B
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 04:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13949300A10D
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 03:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD45A495E5;
	Thu,  5 Mar 2026 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+xp0Xya"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8884457C9F;
	Thu,  5 Mar 2026 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679705; cv=fail; b=gdjYEiJZUQX9v5wJ0RCTMCq+fGSzo88kN1Rccb/YV8Wh88JlFy2ONgh26e/5wJPWoijFGT/9CRjGzaWho26sOwK7y72rPBMp2QMdfmWmVl441/PD1fyXzeBtRnbpYlkszDxS+NlRS4y7Lh2fpHUjWgHaHZDIajXBFzETBNolM2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679705; c=relaxed/simple;
	bh=GQCY47dVzVT949jFCciHdyux2oO37DLJj1jdZaV0Z3Y=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=qeE3xjmDbOga5C+nZU2clMrFj4T0KnVGVwKeNAvkvpBoQ5gQE6rm4RgjM+8qrMeJaVMhFegcffxjo9Vu1cNLkIW8zU/MzDJCpzCQnYRQhF8X7zvUoNNjewYUK4AkcrHVIwdELXFl4lyeMDTrcD+LhSW3sw7y+iSdmQIDYnFi32k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+xp0Xya; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772679704; x=1804215704;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=GQCY47dVzVT949jFCciHdyux2oO37DLJj1jdZaV0Z3Y=;
  b=P+xp0Xyam1HRZSm6s0ThrHksdUb9LBzXaL/cGBWXwjPeuhtupWCMe8K9
   ye3+RpjoSU2uaPrUjG5flUl8/2B/8enRFUtrn0USfJV4nkaz/y1Jsj4er
   aqiHeDXI1eT1p0bb1/MPXFHES9xcAm8Nb1NEhKINczX9EqvGQwkkPCMfI
   qHUZUyfrkPvWAPnLXuraI+CarJdMKdZhBsyfahrpRehmKHS6TWhoDRgS2
   nfPilf0qNGJhq9G8JvUAaF7pOoyt8KTqwQL5urO2vxh3eyme9/FFQJLMt
   5Ms953FUDXrvUQ25BhatcZ3PoK7RsGY7eofuCObCrjGvlpsjMU1/V6Yz0
   w==;
X-CSE-ConnectionGUID: HoQIc1hDQe+xeYaQ3P10QA==
X-CSE-MsgGUID: VV+bphbSS7GivgXRS44gPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84390580"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="84390580"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 19:01:43 -0800
X-CSE-ConnectionGUID: 3ObxBll+TLy30EuomNFsgg==
X-CSE-MsgGUID: Nj7y/4XfQ4GxALE92U30dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="223035819"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 19:01:43 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 19:01:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 19:01:41 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 19:01:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCKcY4o+0G8dl2ZWO9Km8gu2wwmBum9Z+17RuBCTf8Dp9uNLpa1P+dxcTObWZVBT0o52/6UEc2To88KzBkpYiUfUm+GGaxgyHxA1Yz/Wdy64eyUpJghCDymWQ02ky6VG6W84LPcNWUiQL7sutADaay7zuMA1ur4P7d+ASfLvlubgnMXps+KKzK1qJNXsm1S+dyvJGPSLBvlkepye/qluMlN+6zByCDr9Y9bNK6qTog3JgB9+apSZ++QzkQb7eu8hMINyZ6EDhubbUn1lqq6ejhrv72aG/T9KUN9mmXSp2lvaKBcg8K+Q8xwYIf53pMD+p2BD53J5D1Sr7yrlUFKdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CS7hSBrVau8lDWFLSTnRmFfImdJuLNbX2ryCohUEnF8=;
 b=Gw+zqb5lUuN8ZeuOeuxhg9CoDiqpX+iNSv4/BPo81z58nnMpfOPjS/Lt8cGRF4W9ph2schQQGxyWAom8TQFRf/oIaX6HhgJesxtC5zhknesUkbAL510lJB1a7+rr/premQfO7Agou+Yx7AQFqiN+U/ZFe3qeaecI12smPmw9qZI6cRCRhRgNl74Jt2Dp7YfKbgOFiTyTRA/q/XnIuOaLrmp0STzcwhLCMZVgwBHLEHmuJYiV4ZTNVkRxKBmmRAZo57KX9uHkooH8MI4QFvkxv5OsXss0p8HF/XRlgva3FXTQ9zc/MALtR6OBZ0RDiCQEtzuymIjJVeRmnGvT0JWmfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SJ0PR11MB5771.namprd11.prod.outlook.com (2603:10b6:a03:424::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 03:01:32 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 03:01:32 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 4 Mar 2026 19:01:30 -0800
To: Gregory Price <gourry@gourry.net>, <dan.j.williams@intel.com>
CC: "Huang, Kai" <kai.huang@intel.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"Schofield, Alison" <alison.schofield@intel.com>, "thorsten.blum@linux.dev"
	<thorsten.blum@linux.dev>, "wangyuquan1236@phytium.com.cn"
	<wangyuquan1236@phytium.com.cn>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "xueshuai@linux.alibaba.com"
	<xueshuai@linux.alibaba.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>
Message-ID: <69a8f20ad67cf_2f4a100f4@dwillia2-mobl4.notmuch>
In-Reply-To: <aajo16gazmWSsXDh@gourry-fedora-PF4VCD3F>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
 <aajOckpcmQwYydVQ@gourry-fedora-PF4VCD3F>
 <178a85c1d5a48938bf866a85d34ee2ba87901d10.camel@intel.com>
 <69a8dc7ca72c2_2f4a10026@dwillia2-mobl4.notmuch>
 <bf78a2ee58e99e1fab9df3b5406f20edf9420415.camel@intel.com>
 <69a8e5a4d2372_2f4a10056@dwillia2-mobl4.notmuch>
 <aajo16gazmWSsXDh@gourry-fedora-PF4VCD3F>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SJ0PR11MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c08e54f-5fb7-402a-2839-08de7a63813c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: CsU5q10JYB16oBQxbt0tAlDpkVsWW16BDRTvqF1i1J5Rpe9jyk5FHaeL28wur2nwN6YkWTLS7Tf8E51tThi32BGR40u1hADSjjXcDvT5wcB7HxVuRn0unKDJRWZc5ZHwasewD0UJkAzKK6G5ejA8FXtUPjJ5mqYPyq5gEpi5R8yr1ZbBFaF2t2NlgGOLeiQeuzwAWajdEkyZr27t0dJkndp3IyiyWpA7/h26g/gZQ5J04fWknHfFZTmXJoWMerbbdwYqzUkvRimD/BHtju78m+hdeJ87IVKak5pJv1NyB1zHw33GPoeVsW+paU6+QidAdQZtqaVZxebGn/CPTG2HiZbeYS/4sAO18jhkDXvEb12Qe1PHQRj/JfpckLUvwdr9pYD36V/FPkbMh2bn7ie1RE2gRi0TbmnCFZ0OR0ba+567O6OkAkcyq9zXOxrTwo/NzdiblRW1LgayM9L6VB9QQ01EeiWlxCcbrhvPkYIAijVJZ+vFTzoQp9VpCjg2/aegSWrDm5HhdVEhFs9S9rpHLbAhX7u4jb0QdZTmSEG1HTgyk/pNW+VXD/Y57vDXQHpeWz82UUBSiMxh1PemdzJGIokenpZq+LGz/An5TKTN7fG2FF93HQ/raPBI/4GanI9W0Fix/GSI4jJWapcWBoYtASPlm4f2E1WUWp2VNOchsVn6dWub6OcUVpj6t+hp3mmAU+xIXymiV3I+x5XPELBipzz6uZCJQT0bYdK2Q/QZDWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFRJMU5qOUhqQWxtMnRLeTZGSzBUY2RBei9IalorNkd6SmVMY3YrVXE5VE5O?=
 =?utf-8?B?bmNQSFY2QndFOTVySms1SVVIVDhibC92YUJKKy80cWV2R2d2eVZlQnFRWUVX?=
 =?utf-8?B?ejBvelJuT1AxVy9DQTl2amFEc29naS9kMXJ5VklBajlRUUdocCtZeWZwYWI3?=
 =?utf-8?B?cWFUc0dKV0doNHZvWDdMTUxCS3ZHZDdKeUJqMEdnRHM2MHBMT0JLYWsvMDR3?=
 =?utf-8?B?QjZqRGNYK09vZ2VYY0NJN3E5ZDNFUG1Kc2xmYjZpalBucFgzS3pkWnNlaWdJ?=
 =?utf-8?B?TWFhRS9PWndDNUN6aEd6MS9qajRFSkRFN0NiMkc0YWMzQjJackc1N1EyRTJB?=
 =?utf-8?B?RHBLdjhsQXo5c1Fkb2xXY0ZVR1AvTFlWMEpsa1Nma25aNEdrZmZqbjN3WWps?=
 =?utf-8?B?K1dFZWFyYnRXUHJqL2NxSjJNTnFrYzNVN0I2V3dBTVZxMlF6YUxlek9pMmVk?=
 =?utf-8?B?S2lKQmo0Yk5Yd2ZTM1hkVGpqQ216MnlSWVVhZ1kzYXNTNjdENlVQQ2RVWk4y?=
 =?utf-8?B?MzAvakRyQWIwaG45RFRTVFFTMkgxTFkzTmxNOW1wS0V2MVJDc2FqdlNDbkR0?=
 =?utf-8?B?b2UvY0VKUUl2Y3IwYlVuMEJNb3oyYVBETUppWmUvVTFFeFpuTGtaNjV5aEdM?=
 =?utf-8?B?d09WYitKV3BQV0p6QTg4c0FEajdPZVlJdkdCdVhteE1OdUtYVVJ1aTY3RER3?=
 =?utf-8?B?RThTOTJiRXJqbzBrcHliZ01PcjlkdFZLSnpuRFdhUWNicUhHaWN2cVhSOHZ4?=
 =?utf-8?B?Y2E3WHdmSnpYMDdxME5IbW9ybklveW5Qek1XM2I4UnVaZ1BjMlk3MUdTVmpk?=
 =?utf-8?B?N0gyMkVkTjBhZlpyaFlsamkybXpraXBETkhodDNveEMzWWdIV2Ftai83TURH?=
 =?utf-8?B?Qmo0L2ZkY0tQcFN0UndNUUtPVXRIcEgwSmRUOWRoUUtCRFF0bDNEWEFRN3dt?=
 =?utf-8?B?amhlTWVsWVBvWkxFaWpVdy9CblFVWTNnMGVIeUJicVJNNUl2RnlwL0w5SER3?=
 =?utf-8?B?VExrYXJxY1NBd3lOWGY3VUZtSllJVFpKUU45dk9ZenBaZ2l0Y3lsYnNicEpO?=
 =?utf-8?B?cHY3WXBJOGVmNm5pNDZWSjhadmZQM2s0RitzSDNLd1U1Qk4zSmM4YStIZ0Zo?=
 =?utf-8?B?TzB2OGNIQUdHY3FEcGVOeWVFalp3OWM5YW93TUhxWlliVGVPaUYvZVNCaDlz?=
 =?utf-8?B?WTNEU1VkVG1LVGpVQW5FRWxUS2RpdW1yNFJtOTN5OVB4RzFiUkpLcUtYMDdj?=
 =?utf-8?B?ejkveG5FVlNvaGxJTWRoSk10QUptM0tmczk4bHJ3ZE5GVE1KODZ5WTN0SnBt?=
 =?utf-8?B?MHJPYnhkM0w2TFFxUXRxSG82YzRETXNzT0RKNFBKaWN5N3Ewc0NGMHZSS1Jk?=
 =?utf-8?B?TWQzL1lCMVBicnRiVldrNmQrMWZiSnVYMWdWemVBVGN1bDRHRHg3cWtIK1E4?=
 =?utf-8?B?d2JTQTh3ZHpPSUEvYUhIaU1Bazd6NnB3KzlDTHZobWU1c0p5dGZheUNYZ3M5?=
 =?utf-8?B?bG5UY0J3TmZ5QlFPbEpCOVA1cXFwRDVkcUUzZ3hNTUpSbDJ0U2JJdW9FU2h5?=
 =?utf-8?B?QVd2L3pmMWNpa3pMamhyQ0prSm1OcWs0NUNxVWxPMUx2b0xCdzV0cGtkS3dY?=
 =?utf-8?B?WTh5bmM4eVRnd1FFcThDbktaTUVGVFg4YUlSTXVWQWdCNVZvckRoK1ZkMFI4?=
 =?utf-8?B?cGErdjRmOW8yLzZaVWJ6ZlRIUktmUGdRRUtxK2p3SFNKT2pUdThFQ2VGYjJx?=
 =?utf-8?B?T3BWMjAxZHlpbXhrbnpxWDBnT0NqcDlUdkNsMEFjWDVRNUhSREpsZGRiU08v?=
 =?utf-8?B?NzBoZHkxUDFVTStsaDFmeDBSMzlXYjZzb2toajl6TFFEWEl1ZXg5TjQ3eUt2?=
 =?utf-8?B?ZjFicHBZTmVwdzB2WW1MQVhyL2dDSFc3TjNReEtVSFZSbDdsSWtmaXlLaUdS?=
 =?utf-8?B?NmdmT2pBVUc2Vkt0bXhBclBCQXk2eEQvQkZ1SlhFTFJkaE9FTU5KcXBkYVFz?=
 =?utf-8?B?amRGdTEvTFZsUG9JZ0N2UkFXUHBIbnZuM3VJV1hFa243K0k5aXhYemRhakho?=
 =?utf-8?B?UVFHeHg1SWVTaFg0aUl3enFheWtKWXBNRHdGMFA1UG0wTkp5VWErMXlhVEVk?=
 =?utf-8?B?d3R0T1JYWlN4SlFXc0htV0hOTHNpeWNYNzRReGY5cEgrY0R6UWJDczFyZFNO?=
 =?utf-8?B?UlYvVDlBWktiUVZ5Z21kbjgyNHN6V1NsVDdNbXBTNHpVRDFnb2NBcDlMUFBY?=
 =?utf-8?B?TEJPNTY5YlNOUkdsQzFuYlRzaWFHYUlLMDJWenkxSjMwdDk0UjVWcXZWTVNk?=
 =?utf-8?B?MGNYQ1VJTitqTDFwQTVsd1ppSC9VUVdYcVhVY2plUGI5eG5kZS9xbnUzbGwy?=
 =?utf-8?Q?towNmehnY1kvdoFY=3D?=
X-Exchange-RoutingPolicyChecked: nz9v57ueWS/CqbdQn5km4vH62kJyHFhX0yyQ6RyaMw56gLB1sVEHaq9Mo8JK/dKQs9zpflUtHquXZ+4Qy8oKCUJMHh0UUPI7gHSjI/vfIawlT4vIhaAhzb4B+FWEgZKF03soxxLvcrTOc1C+McIClOSLZ2QPpQJN7EooNANgT/Ievvk6+puFUZXKdZBSA9hNrZWcka+WIvyLbtEfHGc+MxQSL1fhHQkL+Nep2kSdnrOCnEf1bjis3ySUokoD0JfvNfFDFoXbiek9YCAVGn5eYq8awyMhEe0e5xH7VpvioiTbSxQcG9UN9g/yAEvg6dPa5eI0HL9EHmLMJzRMPX9IwQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c08e54f-5fb7-402a-2839-08de7a63813c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 03:01:32.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBTYfJmh/jF3jI/id3v8v2BS8PojDApa6uSF4wo0rXvw9fMqobtQamfbQh3tMvFtYcCOf4TR+4AzGNWPbEU7O0RwFL2dq+L4zUeEuvrEFZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5771
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 351EA20A64B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21386-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Gregory Price wrote:
> On Wed, Mar 04, 2026 at 06:08:36PM -0800, dan.j.williams@intel.com wrote:
> > Huang, Kai wrote:
> > 
> > A small 2 line patch to save a few megabytes of memory, sure. A
> > paragraph of context that almost nobody will ever care about on a go
> > forward basis? No, thank you.
> 
> eh throw it in the changelog *shrug*, i think it's useful context.

Definitely great changelog fodder and yes, useful context.

