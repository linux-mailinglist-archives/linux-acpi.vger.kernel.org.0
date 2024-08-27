Return-Path: <linux-acpi+bounces-7860-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275C5960283
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 08:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA000283D5E
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 06:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B799514F125;
	Tue, 27 Aug 2024 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hOZ1/IBM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA47E76D;
	Tue, 27 Aug 2024 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741586; cv=fail; b=QuthXk9rrfRdNCzz4GzacS4VHzy6tHAoK9nnOEkOzlcxO6wn8dNtafGVIgC+CgnC9GJI1yCP2C08Fv9mCai3jmsjpdjwjsbRKAee4gCM2w9z2DjdL0/xuSdMetw/XrUgA38Iub+2ZSQr27svPKQGv5qVkL2le6bs1rDOuicTVlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741586; c=relaxed/simple;
	bh=VIzm9evVKLZu2zW1TWmfLUzBY4eLQWAIHs3a4TGMg84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IIl2GxnwVjzCo24pOXljMxKFSyUqMfyzwGnXN5G5dKVN1mHM4rusnHLgdAxjGPbnb7agPIJP7sgLXvfWiBYR8zrfYCqJZ4KP9h+OEH64dO0zq3jpKKAEs1FBJmzQyhgZP9msY7ZqLswzapzSx+R3Wura+q91FSV4McU9B+OWArE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hOZ1/IBM; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVp/d7v+Z5KaBk7I1uJNsiUE41MK0bsBxqL8XJWnqKSn9r9VVMC/WIr951yJDJQGcGZHYF1h71i5wQXM3hE2jn2xZjZsExiKXTUASZ69FUiZmsBDRN1CwiyfqGodFaYJCIFqdvbKqMxF+oqt/h9/bj60+/1U6Y8Ib2fxvGfCYL8VUlP1gubh/IhPNR47Vh/o74EIPpCFyuIbPEkk0zgYM3QnwOVd53lwphwm1IUWyWBCKAE15JLn/RnbQXuZx3lAc3uQIvQ2efGLdymlYxM5DIuPNZaxwc+29Bawz+ujE6BP/RX3y+r5dyx22AWfb6vgKe0J3qCu0Zsu9iVWkSBmzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5Nizo1kdSXdYLqzkk24Rw5s6SEwlfwcZnbEbnBw0d8=;
 b=vcjrP+WK9J67K6sykJ5fyrNNMRrAeXxWuTKl1bCBpfT+1SQwPMLG3MQdY4dkcBER2NI/g3A6vcNflMih75AXwLCRn3KD8l8SAmJIX7HbZ1cJiuGDXGchQhWJkaHtAKN3CJYLH3hjbomhWTI8GHSUprt6FkxjoFKZE/+ChxW6bPT8BW6hiXRx1pbqGI+XGdOxrI83kvZF5QuhZAk4jCE1z/LcZUFxCAfZJ0VE6KivWCUKhYbN5y65f6Or3e9INHiEMY784tkaWaRjtwHvj7y6FwUXaDulIiBuL5fcEyylPJzjJGSmJTcKnUb0lJg0M7e/5dp2dc2V95/KUS7kV1pAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5Nizo1kdSXdYLqzkk24Rw5s6SEwlfwcZnbEbnBw0d8=;
 b=hOZ1/IBMzGUF6u5yGYI+LaNdQBnE4N3v8S26V8/O74nSkSd4mjKZFY88wxGGgad6IfslUQVx5Qlu1dR8Ph4Xm0YytYWSQOBo3uzIGZMyTsBNpRqFsHp5ljcXx63nRD38INLSGjVUFpN6XA8ElLPgkkRJJar5Ul1cR6AOGijgtLc=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 06:53:00 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:53:00 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Mario Limonciello <superm1@kernel.org>, Borislav Petkov <bp@alien8.de>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
CC: "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT
 AND 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:ACPI"
	<linux-acpi@vger.kernel.org>, "open list:CPU FREQUENCY SCALING FRAMEWORK"
	<linux-pm@vger.kernel.org>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 8/8] cpufreq: amd-pstate: Drop some uses of
 cpudata->hw_prefcore
Thread-Topic: [PATCH 8/8] cpufreq: amd-pstate: Drop some uses of
 cpudata->hw_prefcore
Thread-Index: AQHa9/0x8aNwae7CZ0WL+O3nv7GV8LI6q3EQ
Date: Tue, 27 Aug 2024 06:53:00 +0000
Message-ID:
 <CYYPR12MB86557E4BD32B6043B25E7A369C942@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-9-superm1@kernel.org>
In-Reply-To: <20240826211358.2694603-9-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6547b0ce-ff38-439d-9329-a3491a083ead;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-27T06:52:40Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|IA0PR12MB8930:EE_
x-ms-office365-filtering-correlation-id: 2a234dd2-6578-43ec-3783-08dcc664e423
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?23wYdfMkoNu+u5MY2/DgwUPFaexOieQZsWc5Y9u56BiBqhyesYOWy+j555Sg?=
 =?us-ascii?Q?B1tcz06im/mRLLxVzQLOyXihLn7Y5S4lgv0liaUlXXQaSLntAXVVbU5/kOs5?=
 =?us-ascii?Q?WvHPIwCkqtMS0dNbR/i6GESoP17R3AUlPH5ZqEm3RPKyrn015g/U++smbCdX?=
 =?us-ascii?Q?7z7XzdR5LAK6BZa/VgtH/XeNnEupdzf+LMtXPspgM4+kwqxcXYuOW6F4QWov?=
 =?us-ascii?Q?xRubTTM7lVInjdsCmWa78XloBeZi2G0SvEgrO9hqYKRH+WV+j2xRLoYeMZco?=
 =?us-ascii?Q?dFnUYKQxxkYE7EqijhycomUn+IPppBUx6qL+GJ2ZC31WgtIRmUrbEmjZQlSS?=
 =?us-ascii?Q?gKWSIqGrvBfiuQVewFN7uFBZlx8UtLUBTLTBmwGQXAzBPn1dbPcOEBknEGpZ?=
 =?us-ascii?Q?Iz9WlkFnB2sWUzWfUI1p5H5j4otbtZ6dbfv5JwF4m6IOQszXJ+2zw/ocIjXj?=
 =?us-ascii?Q?B2wWND3jet7kPHg4Q4G9wMFadhXzQCf3FSncCwl8SUGF4kFvoPXAJsbvgLWz?=
 =?us-ascii?Q?EPBmfpbyuW0noN+E913e3//2HnNQDzsHXGx1nuLY/uET1/DQ3rejdZF5Le3C?=
 =?us-ascii?Q?vj7pbQLyacTMiM/LE6h96n3lbWMme0rnKX81kTody5lkbN4jLYkY4eCPx64z?=
 =?us-ascii?Q?HzoBPZVjRIcES9y70fJbTXWO63nDgsEoF5uaB7H9ICVyLs2lvZpg3kETyv5u?=
 =?us-ascii?Q?35p8be5PFp83hLGZiPrZMKeenMcvl30DPqpds5VUOU7wr4JwuoNcaHpS2jRQ?=
 =?us-ascii?Q?8hyTKQQys3oIWmhi+JAY3LKLogLDHKnRl/5xos0sWcu0t1RkJSTy7vSn1+bz?=
 =?us-ascii?Q?MtyVqbEmrYRi4+R6VjwqaESeoHWfXpOsdkrV/TIHat/rgmTPqgK4PXTbXHzL?=
 =?us-ascii?Q?CPL+2BEXHbhajW20DsoVYp4otKyN1/zMhq67t47/kJwVdIojBDki2tdUjSpt?=
 =?us-ascii?Q?BZ17+6p3Wd3qkkYLMXAJWeTaD/UTuXgQrhuiivxXQn1j8bwBZpzumHlWLDpG?=
 =?us-ascii?Q?PW4HScH8G0KwIIfksSqY8R0dsDLRhklRCRW5NwYbzPv4DkT3uRkjpGZKARZW?=
 =?us-ascii?Q?hRJytK2qc153QDTERSGrf58rVUBWmOjF5SzXRQqzFbCr8TO1WNzhjDAgorXU?=
 =?us-ascii?Q?Yiby2PiwxQ5DDg3QMI/PWD2pXlbvE+7lQKnCPppzfNVkSwvozOU6pfZ7FM0l?=
 =?us-ascii?Q?OCKbfYLMGdeDbZ7dN2SAngQ04sUmBwki9TVtK3rdSe224V4XCKHOtjw4FW6m?=
 =?us-ascii?Q?kzZA8gY1VIsHucYO5retl9qpPb+y/BMOc+Z/6c05ilY7R2WYXCTyp5WmhbQt?=
 =?us-ascii?Q?44R7sWrnnIIcxJe+/TH1tPXytaBplKUkEavC64lc3pBO3izk7PPF4INNm2HR?=
 =?us-ascii?Q?QMSSeLdydfUC1ipefFHRDSNWaKgKyrF9WLKkmah/B10BbJRQrw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v2qtvGe+kPgW/X5HvFj9uxNgWm6g3fw02ss5hNrxKLbu4PNb4qj2lwgRfnyH?=
 =?us-ascii?Q?gqU5wTLciWvuasnYxEp4D02FS4KoEDe0RRZZPhH+bwC4FyrPGuodhlyBra1j?=
 =?us-ascii?Q?IwjhTZO06JEN+IYVRxPEN3tUcbt1zfZT2+gbHssBWuuMgGmpkcOyqwGmpum7?=
 =?us-ascii?Q?BtJvS/P9jdOPilr3BzD/KqiK6jh2GOaPwNgP2hHa28VwkpQExlztNOifgjV6?=
 =?us-ascii?Q?Z6bBWgv2qlY+XZQhkprTNZFpi+i1XTI5P4edfQc0b4r+PehM9a39TTop6zGe?=
 =?us-ascii?Q?HZRll3iM/drQWlWsJNLk73ZQL9A4vZyuFbF/RweA2taFJ37K9wge69rCTA9d?=
 =?us-ascii?Q?84L+g5ge3E2hNpcmGt9Jr9kDthqgd5Rerylo9RIRNOQzXEjjHJ5lSFXA8Q7i?=
 =?us-ascii?Q?5TeMN8yzxhNgr4bWacLPRuk0NpsuIMcSbbO83eWBQ9Ev8gv804p7pc6oiFEW?=
 =?us-ascii?Q?dlrJI1FcC3yilw/rVh6Da7SxNL3ObP6VX+ocQfmfpQPq6ReEAG1tmKrBBrCS?=
 =?us-ascii?Q?5hQyaWM2cs3Gb/Q8Stl13mEz3aim8M5rbYyo8zSVj9wHGK0EGEzgciZhTHrV?=
 =?us-ascii?Q?3lWSlLWAN9g5ArRalFdp/sQWdzj7Fk/Cr2u5VxlM0lg3eo3pFOMk2esr9fXu?=
 =?us-ascii?Q?toJJgOuG1+g5WHKPIBZTcbuFsJXTPfqYYuMFiaPyy0Gq8+vh0u2IWOTklRoI?=
 =?us-ascii?Q?wSEJyILQFqu3QbF8JIDWduGwNU3yBMNZ6cjlpF7DgGAOOwd8RWvk5w2B20Wg?=
 =?us-ascii?Q?syYOEc/onYdXT0bFaxISSl7PQcbO3AyGKARTr/oZyuQV0d6vZ+NH7ojZ59nq?=
 =?us-ascii?Q?rt80xcCg/JPGDtC/9khhhx8tbget3bk+SMhpft7STP0p/1JblpNoUZc0WPt9?=
 =?us-ascii?Q?BUEzaz3ZW249kREsynamKbZWzQ422DaeLKHSfJ7CgtRwcGkNXkmIW69i1mWZ?=
 =?us-ascii?Q?OQrfwj3ZbedTcis8wUPAuJxXiB+wxVXo60os4Y/9r+QUuyaMQSs92kFSttpp?=
 =?us-ascii?Q?x0uS8eEnPdgFK6okJyIm/CpZ2pcReCseYcs6ThAwE/K0a2Pa69Z42AO7v/yO?=
 =?us-ascii?Q?RtrDvO7hcNoMYgmZqEGkrSZE/Az2I1ir9I9CUM58hTy1niOKd1qLar4bFbRR?=
 =?us-ascii?Q?TwQMZ6n3CmfpdDOu30lFWbVzO2P7dIMUQtKHnKod3AuwFC/IB0uVsUx5sydD?=
 =?us-ascii?Q?5gnymcFNLFPM66GbqtgHe03BBfMVh27nAN0zVLwsSJRZxTfmutbu3r7TbH8R?=
 =?us-ascii?Q?6ma1xfSXZweTV1DDZL72j45NibVRVaPxVYnTmRaqS7EXLtvTQQDpsJY1lqN6?=
 =?us-ascii?Q?gze0LC+XFy6SQ6Yu6/udg6EsQ7I7qf7K7YQJ5AJGO3QprgpgKg8bMvcr9RRH?=
 =?us-ascii?Q?zGtGfIBjejVjwYQnee2YYJNG8Gg1nO0v9BsEa+sWPNEdfVz9shJjtwMKczkS?=
 =?us-ascii?Q?Y4xIaLlyztMiqUuV08wTdYaIqZqbNakMHlpTKcXT6+NNkwxMl23bt+5q+nkU?=
 =?us-ascii?Q?Ok5vD3hyD5vWgCw/rrrZgCq6+ztJ2BrR2qrkXGNctsffhV5Pgk+ZRUt0whkg?=
 =?us-ascii?Q?6F1Xv9ye4t9eUXzphXc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a234dd2-6578-43ec-3783-08dcc664e423
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 06:53:00.5953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8o0WEqNTegC8R70QjJsZQ/5ML/euTmWnlGfnyyul+xv46YW/dKowNcQZqtljVRRZ4qMIQ9yBx3wqgqZSZbaj7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Mario Limonciello <superm1@kernel.org>
> Sent: Tuesday, August 27, 2024 5:14 AM
> To: Borislav Petkov <bp@alien8.de>; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
> Cc: maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT) <x86@kernel.org>;
> Rafael J . Wysocki <rafael@kernel.org>; open list:X86 ARCHITECTURE (32-BI=
T
> AND 64-BIT) <linux-kernel@vger.kernel.org>; open list:ACPI <linux-
> acpi@vger.kernel.org>; open list:CPU FREQUENCY SCALING FRAMEWORK
> <linux-pm@vger.kernel.org>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH 8/8] cpufreq: amd-pstate: Drop some uses of cpudata-
> >hw_prefcore
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> As the global variable is cleared when preferred cores is not present the=
 local
> variable use isn't needed in many functions.
> Drop it where possible.  No intended functional changes.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ed05d7a0add10..257e28e549bd1 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1112,12 +1112,7 @@ static ssize_t
> show_amd_pstate_prefcore_ranking(struct cpufreq_policy *policy,  static
> ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy,
>                                          char *buf)
>  {
> -     bool hw_prefcore;
> -     struct amd_cpudata *cpudata =3D policy->driver_data;
> -
> -     hw_prefcore =3D READ_ONCE(cpudata->hw_prefcore);
> -
> -     return sysfs_emit(buf, "%s\n", str_enabled_disabled(hw_prefcore));
> +     return sysfs_emit(buf, "%s\n",
> +str_enabled_disabled(amd_pstate_prefcore));
>  }
>
>  static ssize_t show_energy_performance_available_preferences(
> --
> 2.43.0
>

Reviewed-by: Perry Yuan <perry.yuan@amd.com>


Best Regards.

Perry.

