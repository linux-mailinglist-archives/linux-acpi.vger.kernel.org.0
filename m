Return-Path: <linux-acpi+bounces-14274-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E987AD405B
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 19:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B077189B38D
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4871224502D;
	Tue, 10 Jun 2025 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNI698zw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89091EA84;
	Tue, 10 Jun 2025 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576150; cv=fail; b=lmUWFYdLf/0A76f0yl3s1PGOD6U8UlBeozW9+6OmXntEPQPG/fRQ+Efb885zqRJ0sVNJJimLeQw10TIVeclYCA7k3s5cqpPIfT3T7XLIa88vVmEaySN/zJnccvNCR1uvUuZtxdiAqm4GMJ2ssIEOAlcaPmLxdu/fb6vrKQNB1uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576150; c=relaxed/simple;
	bh=T4vyd0BgAYgzXGTOz7sguwZ94vUyHs1YawHNyPpeVzg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sil23y1Q4f1UqgVTihQOtYjGCB1s1z29j44lbGFkSufLq4hcprstEYUmXP0REsL+X1QSESsVv3NekxG50SgyeVzvQqiHCGEF+mQXAN7XvMAs9QYuu3YXeHgEy6aBQ4hDetZ0PojnjrcrSnL2KXm5h7m+l2DP8IvzpNEwhW4wrj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNI698zw; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749576149; x=1781112149;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T4vyd0BgAYgzXGTOz7sguwZ94vUyHs1YawHNyPpeVzg=;
  b=NNI698zwuouPks+KqpoLQjM+3BVDeOTQ7HwhBKr7rIjhXg8FKYvF8aSL
   c06NTdtaHtjHttDV6X7Eh5opBLLgzXPG5QR/biv/b0uTz0feN6lWcasfk
   i2Fc5f5Y2HwneTfxQpHvUGyW2Gu0v5uhYEBB0EzqL5+l0U9zceqOkgD0x
   2graVQ4ZUudXpSa3zF14npcNuwSe+qGNOp/A3vpaosnsQZs/WzDkKlhn3
   haHQWK30WhQ90jEe1U1XLOSIR5jlCTfi6eekRoUoA2GUB/698vR3dz6/0
   sQOLPl2UZkVFIPi4arEGVBC0Qkt5oPAgZ2+Y3SVGYK9UBWIOMLxrVtm6g
   g==;
X-CSE-ConnectionGUID: vLq2XVg8Q2u5DUe/OX7Bew==
X-CSE-MsgGUID: lbbvzvsjS5mk1kGy7OeVqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="74236604"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="74236604"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 10:22:28 -0700
X-CSE-ConnectionGUID: OQV1Y59mQAuxLuvehzieng==
X-CSE-MsgGUID: 4FArsBM+RWOm7lT5z1tzXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="146816219"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 10:22:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 10:22:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 10:22:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 10:22:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYWOWWXVZAo2gc20P9hq+eBybb2TF3vQ9a6+DfOS9P5CB5MXFQYmrzXkBepO2JA1Cni1oljoswUIC2JTYrefQjtJhvWKT5NQYb9zrOp+qytsAIlNMkyxoU7S9bEcMTndc+2VVhs+8cMbbQZpA9dDht6fefyW+o5X6sL81RBCLGhYZ+iWq8Cv4PaVu1d2oNYeR69h+MRlyTuket8cdiMdEyKJ8pmZWfdlpXfFFQiLYCCXjUby1OsBw/YnOcRT6VF2MqcZpduwxfrLBBksxfyFDeaAGr2XEGKrUsFte4WjVUvXHxVSsIgucparFc0tL0MoNmkuaxu9PPhVA+mSu+nIkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2/lm43fQO3Z+47FQoJkVzv9sgAmXEKWCWXLM7wszcE=;
 b=a/5a8Y963V+wlfZq0RuTOfhhu9vYeXt+iLBuRF6oDtXnGBrTyunTey4ROsRnosUUDWpNsgMZ7ueF0IhfdnOkAIBBhiRpyih5yxg8qljI0jtsNzqFljOYfZzmJVACFJrOrBimdzxy/NokIG1phka5VDhbS/51OCJTGY7FW6V+8LadpFe8aGGxGmw4Bbad+WJPfoZ8AsqZ8enYga83OJcCuRcXvwn4cGPd5Z5iBfaAh5aP/DvrQVr6hguZ0s421FUK447dJ7EcggT7yYmquwZBtqqt6T9Yj3Y7g8hzufHw47n/fXGzawjKVpSD2PU3WSbcEYbeEmsnLorhfakj1FO6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA4PR11MB9250.namprd11.prod.outlook.com (2603:10b6:208:56e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 17:22:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8813.021; Tue, 10 Jun 2025
 17:22:24 +0000
Date: Tue, 10 Jun 2025 10:22:20 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Greg KH
	<gregkh@linuxfoundation.org>
CC: Dan Williams <dan.j.williams@intel.com>, <rafael.j.wysocki@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: Re: [PATCH 3/3] ACPI: APEI: EINJ: Do not fail einj_init() on
 faux_device_create() failure
Message-ID: <684869cc8777b_249110016@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250607033228.1475625-1-dan.j.williams@intel.com>
 <20250607033228.1475625-4-dan.j.williams@intel.com>
 <20250609111758.0000258d@huawei.com>
 <2025060954-district-breeder-2c3e@gregkh>
 <20250609170509.00003625@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250609170509.00003625@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA4PR11MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: be9fa05f-15ca-45a2-9dd0-08dda8435d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FoYwkacm0z9L50jFgYw5oPVcY2DDrgsH/6deYu4NTakrpQQT33+Qrc3OqKai?=
 =?us-ascii?Q?bgPjro9bwQ52r+ngJrAf0FfwgzDpue55x5N6I4NrJ0O1gasEXxf2dfNsVhGe?=
 =?us-ascii?Q?0daHAg4VwkZayB2i7DureLU9XrCxZDc4dFuXuMuPdYvri/QT8C8Rq1+Ikzdv?=
 =?us-ascii?Q?HrYs2VLMohgqvLH5+f6HWcBUR4XGz8X5+o7jfBUQySju1iBflodRD+8+vRtk?=
 =?us-ascii?Q?XVlk/BttzLkFTb13XXff6P0Lbnyo/e2lu1Tla7jLb413QQH+v1QLkV3EKLaG?=
 =?us-ascii?Q?aYh3na5kmIcHjFyAIxQzQxHI4k934kSvrD4FchHQzUObNGPjL6STe38Ge/+B?=
 =?us-ascii?Q?I7BDtHl2tpx+/FInPIIHHFoClG2v/7MH55qblXd1c1Ivo5HNXJZYM5kI/il6?=
 =?us-ascii?Q?aToYaGXwbb2JAdRuiKgNwfa7bcdc3bqrO8vwB9mYx+sV/iq16qX7JgMzrZcp?=
 =?us-ascii?Q?CCNBqKGfhxHiPJibL8BJOXGKd9rSiMlJv6LopcC3ciCtDnAqU3OmUVbXmUow?=
 =?us-ascii?Q?ZGeeW9TyLBBUB0kHyuPvQvQDmJq8FIZ6zIbuWwACFgVGCmvArclfSivoI474?=
 =?us-ascii?Q?ynPYj/xhmQ4okX9gIu/CW+e9j9WxBxYnjeqQfuz7xsWZTaSnieov26R/wT02?=
 =?us-ascii?Q?spLx/GLPpBKr0PL3qgT9c8AfyGk9ulWbVHGSEgdrISQr4Z2rD77bLHmnWykd?=
 =?us-ascii?Q?hNrCweiiwbb62CIEraYsS5fu+loIwlRd9be5iBcRqm2ITQkyte/hhC7ZYXcZ?=
 =?us-ascii?Q?B7wO6Dey2g75NpSdL7O0TVRbVatmw8ov5Ffr4AsOflKeujj3qs7RBPyuhRJh?=
 =?us-ascii?Q?0otyPmJsN4woNplnOdHn9Qcc2ggCjP+Nh9UXOb4azcX6ITinqtzY7pIKMmM8?=
 =?us-ascii?Q?jOsUQl2wWjcTwLTRqQnNSPbBrlctzMyBoZeqy3atAs/g6RPohs6npfEHtv+5?=
 =?us-ascii?Q?S02Yk4C8fLKEQwTJE0cqZseAYccl3wHfTQZz3xzqNjC6kRdIeYxqeI+XkuVi?=
 =?us-ascii?Q?GRBQ9Mgwwub/joQhQLdPe8Wx7/Z8MG7y90dI6kdeQLyE1i6tiiKk+hIiVBJL?=
 =?us-ascii?Q?6yBRi2K38zO9clDo4gN6rvKTWYRAxFgAT+kXncjdlB2KMjDPAKqZXlJTx2Sn?=
 =?us-ascii?Q?dH3YLOb6dDQpXVNWUssXdt3Q2DpR+jQ8k5Ok6m3/d2E7XdCeIYjth52/k8hW?=
 =?us-ascii?Q?X4LeSCYKUPVNO31Mqev5AjTW09jeQMRAOSPz9HwrNeOTfQ7cLVfv56ByN783?=
 =?us-ascii?Q?iDmOMR41vAZUnWGwRs2uDt15YEBcxw8Y0/K7BuPsLzo/n8PoPoH8+6EHLQK/?=
 =?us-ascii?Q?tzP973ktG0ZCAxz8nfTJwlfFs1GdJtS462sJnGhrxbHQBVGa7FVIzMO37vMs?=
 =?us-ascii?Q?K+SFFpQVaZ9ZqhA6IkjJ3t00P0uJaerkqQZQEtcI42N7f+Q2fg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h2fSvnavYqwqjpwc5jUvrTkMFTUOTdrSdMEetTqbkgUl3O783IFMdApabTv+?=
 =?us-ascii?Q?YN7sHwpMHWRacrm/LlUXWfVNNQ+P8t+pkhrYpwVCC+0BZ6s6FWU9PECU2KU+?=
 =?us-ascii?Q?nUx0Z0ETQ8y3l220vWJ3BSOXosL1MGDqUoXv61Gkp3j/H8T8vvxaqlFTnTh8?=
 =?us-ascii?Q?lAuaPu+7aRgCZGmv0S4B1yxO6UJGaWmvmolLMNMBt0tJQnM5n5FKePsTY1Xh?=
 =?us-ascii?Q?Eyn8h0Ku8gCRd6jf36bJcam4nZYM7cLvNVpxTEJyM196AQP+XdVCtykCYMrP?=
 =?us-ascii?Q?LSDkvA/okbZblR/S1OF5CgKVCda2FpdsU8b/NUdimg3zMsZjArcG4uh840mZ?=
 =?us-ascii?Q?lx73I6zWqq+hqwe7uGe5iHDk53He417aylzHdSgrD2FZ063oxNUumG+fTo8H?=
 =?us-ascii?Q?wz709RbNMoqdTO+nIgsi2L+M+HUKMeacK8/dPdUTMFBmrN9x8rXCT/KUjM+5?=
 =?us-ascii?Q?g/LOqVL56SXtr5yK1g/IZ/qomAED2EX2w5VBWYJMjvzUjCAJSo++73elmArP?=
 =?us-ascii?Q?QSqvbJue58/ORAsVZSuFXu0eVP7QpuAL+z2s5OGiMn5gFJBRlfiG0CZyAs8m?=
 =?us-ascii?Q?i6NEUlwvef7ectOmUYPV8eJHyVuGC866tRlMIzz9U1VS6jJ4P7hpii6TK1Iq?=
 =?us-ascii?Q?0bS6Cxcykvd0C/4lmaQk9HcFaPyey1L9GxX/8n6WLKcQ9YR2+8e1jRAViDWv?=
 =?us-ascii?Q?a7VSXHcVhBv70ynr72efQRgD06CINUxqFYYicOHIZD2/AlSqAWMsH4Cq8DjD?=
 =?us-ascii?Q?UjDapYLl3bYHTKmAsoB+Ryw+O+PuZAgncMz7cgZMPuqnXLOFHiMyGKwL0EMz?=
 =?us-ascii?Q?NZ7StukgYX6Kbttovj/sxbKJ4Sh5yW74vYlltFC2tjszWoygyqNENkrL9sci?=
 =?us-ascii?Q?h3Mov1LvaiiSYnrJHvdT2FVMB86n1HOp3pKRr0fHzs455ixk+b7p74WBm99W?=
 =?us-ascii?Q?pXNltsViRVhscBa19kYhG9SlRwwqLALONOj0gp+lGWihpFpwpnp9C65gCtin?=
 =?us-ascii?Q?QHvdI26JF25RUbDT/84lxwoux8J065CaKOrwlTSUFwB9Mfywy3g7FkUcuBU1?=
 =?us-ascii?Q?R7ygGtQswN7VAoQPqNyjjteYHiis6QQUGQQEwE8bf1FQHgq/Cpd/uhKthbGz?=
 =?us-ascii?Q?zfdSLtimx+rHcK4tHVtm5XczkXRCRFjkccIxmowAC1jBAilwdUEGz1GtNIT5?=
 =?us-ascii?Q?DXZQZ1aHzRFlUIcGBhtQs9wYTvlwR9YMd26IZqtMb3An3QFCK3fP/0Q5Vfbd?=
 =?us-ascii?Q?8U4VbdtORWSr9ybYajbRJe1GoBV0PqiyEwebx3/mzWT66nvXX2kjt5fGkXki?=
 =?us-ascii?Q?pgylQP2dfK0sGnXvRegyzQ6BHBBwGlAzbZeJdI3hCkRwJQv2/cCKKPUgW8qg?=
 =?us-ascii?Q?IZkrUzjo87wIHBcM1edaBzZ3J4mqsv9FxFrrGqytpILpNbT1b4E47iXQwxZ/?=
 =?us-ascii?Q?igbt737BvifrzqrWPtxfg9ktNln5cHy27/e1iCYdkV5tLbqzDirYtTWhCW4d?=
 =?us-ascii?Q?gZccXfU2j38b6A8qVkM20VlkEuCh9rdGp5faj2HTO2pF3kxIaB8VSt2rHeDC?=
 =?us-ascii?Q?KEiEo4aCa8rFSSm8YST3x9109vyp758UBxWBWUnpIzmxwQHfUZSUxHDhKoTW?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be9fa05f-15ca-45a2-9dd0-08dda8435d67
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 17:22:24.1078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daoYLB5dy2c3AMlOhOqDoGV+E1fmFPVj5lnkXSDQXV8HodxQdvbw2126UQ3SGSM0Qo/VJyxM3jTJkPiNnXKiXtbOY1v3ufpfDU/sV3tbjd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9250
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> Hmm. I did some digging. Seems that was debated 10 years ago without
> a huge amount of clarity on the answer beyond all sane people telling
> compiler folk not to use this in optimizations :)
> 
> Comes down to whether any dereference of NULL is UB whether or not
> the compiler can just do a simple offset calculation.
> 
> Anyhow, whilst fine, it's still a little ugly to my eyes :(

I recall we had this conversation with Dan Carpenter on a smatch patch
and resolved that while it looks "interesting" it does no harm.

For this patch I am not motivated to spin it because even if the the
compiler took advantage of the NULL check to drop UB work, that would
only mean dropping the assignment.

Otherwise, this conversion lines up with the intent of both
einj_initialized and faux_device_destroy() whereby faux_device_destroy()
is already prepared for the case where faux_device_create() fails.

