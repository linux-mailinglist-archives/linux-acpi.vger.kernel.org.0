Return-Path: <linux-acpi+bounces-2971-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A32836E8C
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jan 2024 18:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A133B24E21
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jan 2024 17:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CB23E479;
	Mon, 22 Jan 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5IgXqUb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2023F8FD;
	Mon, 22 Jan 2024 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940410; cv=fail; b=WheorbxYiEDY2hShZ7/KZn1NAiSdNkUtDcP2QiIqFk3/8Ehkx7x8PT2sQVLucI9dkZDdnKdPzQUrO/0B9xztRw6alvMv+fpiL51M+mcep/lvSrtpHY/AeLPcgDeOvxxcN/+lnliV0x7yTlfs5bnrKyQq0dKNBHO+Mbvw0QwgqwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940410; c=relaxed/simple;
	bh=PCazvGuIDUk5JlHRIt54ZYQhzGTrPbOe9Q42iibHF44=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qmB+k24hISobV3nZaneAODZXUbse4FFD45REXN3aqlg08k1BnDJ99mfPZvGQTx6h5GLFwd0h2m1G9cN1msxMh9COET4wsUVjGN+XHWFYtvdU2jFjFF55qXdDQWfWJxIKPe1JhA6eEuIXMkHH8mgQX6/vl+P0R7IaYLGHQJbE9/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5IgXqUb; arc=fail smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705940409; x=1737476409;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PCazvGuIDUk5JlHRIt54ZYQhzGTrPbOe9Q42iibHF44=;
  b=e5IgXqUbt7cBjyIJzoBz5OrCoRhNwn5x//q9a071FK6K5autZFQtp2Hv
   GPe7b0hr0aQ1FqQfPCyOK9DAMutPquNTdXd59XB0XF8xRcwqvehNkQKi3
   9ibDXU82Z2q2Akm/juB/Gv4iFRyUfVc5C3vvGNeCOl6JhnIoYfTaBPyQ5
   EjcCH0oGLOO1/f4Gn2wj5bzEzI0koLxJ93ss1A724ioBdqGM1ALXgtlFF
   ndEbwxKhLHgVEim8pbcLT5295oAaOX0hW56aPAVhJsio1HUPmRlr2UEsG
   qHzhBFN+wK9e3un3X+YdTE0indaaIzmGNMofZUJYj7RYkaJE0O3RF7sm7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="400903191"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="400903191"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 08:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="929036446"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="929036446"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 08:20:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 08:20:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 08:20:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 08:20:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 08:20:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J87yjw++nb6zi3flIP2jyQgSGMJ21qTVmbrwmTYak6weAtLn+tDjR3Qgp98IqQqGJOru4HsBrGaYIdzlNxpBFW90zagR3r7fIhsGBvI9Ka3lVzOzYNMZAiqcR+m6RmEpWj/v2/SK47B4ldWDq4AUs9nDFw3c3a8dRDY+hVnZPpgvw0SOXhn297eJlhLbA1/u7igLoA6Ch729GwuckP90UgvcBWsKLpxE9cQl2ihR/2kPBPuEPGmOsCgLzsrsuddZFk2Oj0x9ix3MEF8+sqr8Ek7k8yTi+F16IsgVCy84/I8xg44nS1l7Llb+GqTJxn810ikaL3tFB9OPr+oh3e5Hxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4S1S8+22hVukX3jqGHavNt7r8RtlQbcaNZmQfH0FK0=;
 b=S676yLCHiMDbcRvGqlaa1yB0bHk6ymFkn9QbC6x90RsJF3Hh+uDdZIZwTQW/g3fE/yH6EZE9mHyij51x6Gb6TGHEiErvTTu/2cef8c7IaZLHUnAnurn54R9h8Y6ZGnkqB4/x5RpIdMN0bPJIGIIpB/v2PpoUPxbbeHLHtsqj/FZoxLguJxYySr9xz3gN9f/RxPYs/iXP5duLIR+pzkA2iTbCmgM3ZnoHDlAtaQOa62i+TunlxwE/fs7oUZfPIqSDJNTe9vSAaeG97p0OUGcg943r5AtfwGGKdewcyCZbfPIpkmrb3z1gvo1dcwyDBTAEWnxDjX8fohJS72+lN0LRzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH8PR11MB7143.namprd11.prod.outlook.com (2603:10b6:510:22d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Mon, 22 Jan
 2024 16:20:03 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::780:d536:ff24:3e4c]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::780:d536:ff24:3e4c%3]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 16:20:03 +0000
Message-ID: <602df940-ec6e-45d7-bef1-9f0c89e008fd@intel.com>
Date: Mon, 22 Jan 2024 09:19:59 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v4 05/11] cxl: Split out combine_coordinates() for common
 shared usage
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <jonathan.cameron@huawei.com>,
	<dave@stgolabs.net>, <brice.goglin@gmail.com>, <nifan.cxl@gmail.com>,
	<rafael@kernel.org>, <gregkh@linuxfoundation.org>
References: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
 <170568501456.1008395.7903809557943927970.stgit@djiang5-mobl3>
 <65ab154b256ca_37ad294cc@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <65ab154b256ca_37ad294cc@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::8) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH8PR11MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 10992e59-cfd4-4f19-9b6c-08dc1b65fce4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDyxzcrsWnJ8diMDuPKUHjNTdAlG+kyvSiUZqkAz757b4g7PQtSoG5P8/Rzd6Ud1cCDBG2U8DDJGbtK0CeC66vGwLgRpQW+xPZqAHcGXOet9Q/gaA5RQ2w7hVwTu/XDQpxxcEu6SE1y5Z+szJdP9ZGBEqwiqCVSEmB0j3Ve5y9NvWAPJpmS6dnm31NeN0jxGmWgwwMtZ0+EvOqi7EQz0YDe6PgkZF6ScX6jcY+Uu8zoPnVStL8L03sXEBd2/ONGX37DEeyfvSkiZhWegRqt7QVg0Gcyg8vbgj6fYvl+MQe0QVdJ0PamFgkF8dgZY/1TcMXo5f2khN74Pc4fedWOlFrtiVlAthpr0qxhNSXauwLBV+FimmMsSRfioGc4dJTk3opSycnlCZS+L3G/dNrFHj0YrptI1QSlsgA1rK/7dDeZ0bdx/TwTkc/9UztyDy2u2DSJ49n7mbXNiFQYZ5wvXKDKWJklBHAGsD6RuQ/Kinx9g3s+oNSbhNzZBK/YozjIWGmBxOd0vK+bIBThVB+LZuJ7YsPOS47bekFI/Z2IOk69ekmExGd9o3MfHxj3YAfddWtoIYa/ZhBCS68/37/C9rrmRv7nYFbF+y60gYfLVwEAg/Bhbc0CAwPZGlKutfjVg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6666004)(82960400001)(66946007)(66476007)(8936002)(31696002)(478600001)(66556008)(6486002)(44832011)(4326008)(38100700002)(26005)(83380400001)(6506007)(2616005)(8676002)(53546011)(6512007)(86362001)(316002)(2906002)(5660300002)(36756003)(31686004)(41300700001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFpvcVYwZ01iYnpyendseXFqWER4SnNoVFNBMlFmS1ExZE41MG8wUHdJUm1k?=
 =?utf-8?B?WHZMYUdFdVlIcCttQlV2aG9jTE9ETy9tOE04dlAzbTBlRk1ldElUZUZ4VWVs?=
 =?utf-8?B?SGVrNlBicmFJT2ZzbFlyQm40Zmk2L2xTbGxqUlUzbnZCeXJzQmdpT3ljNk11?=
 =?utf-8?B?V3plTm5VMzRuYTJCQklra25JVHR4MjdsTTcvZ2wxY3VoeFdzRnNXZXR1ZzRr?=
 =?utf-8?B?MGxSdEVJVWdyWnVJazFnQjBjcEM1V00vdE5odFlXMmduUDlxQ2k1T29jaWxz?=
 =?utf-8?B?K201SThsbDM3RGhpRlJ6WCtYQ3FXcEw4a0V6ME1xWnJWTXRKbUlXb0pkaDNW?=
 =?utf-8?B?ZE5NQUtDMkZxVGErZlpSR1F2bkxRZGVLOXI2SEY4eUhNa0E5N2UvMm5WcmFO?=
 =?utf-8?B?NVJiRTRweXd1WDF1QjhDeTgzdUFiZXVYVUZPd25jN1Y0MFkrZ0hxV1Jjay9a?=
 =?utf-8?B?LzJydkZzTlMrMjhLbmo1NDdhTm5tS05vRUU2bXFZTy90QUV4bVIvNHIzZDV2?=
 =?utf-8?B?ZHdEZHZyQVNDVGU0a0lVODhFeW91elhiSzZ4bVFleCt5NG83VnpxVlhuRzRs?=
 =?utf-8?B?dGFwaFFjeU9QdHBlcWVneDdVQnlTRHpOY1FoU0VqUkhvdlZYYXc1T2FhdEp2?=
 =?utf-8?B?eVM2QkdmemZQUi8vV2U5aHUyWnRNSStCSU9EM2Q0Z3FLVDBpcjcwMWhPdDk4?=
 =?utf-8?B?bFh1VXdlRmdiN21xclA4QUcrS21qNnpnOTRQby8zaUdMaGxEb2ZWa05UdEVJ?=
 =?utf-8?B?aytwR0FlVElhang3RDVjSVdjZ0tjanBpQWpqeDVaK01tVkNCdzkzRTJQODBm?=
 =?utf-8?B?M3Y4SVpQR0JmWnNJWXF3NVNBVjd2MEFsK1pkUG9Hcm9yalRHVnl2UEhhNFVZ?=
 =?utf-8?B?MERuTml2Y2doZFpLMnAxZGMwTlZiU1kvNmM2ZjN5L1kxRG9FYlF1aklZTzJ3?=
 =?utf-8?B?OHJtN2Y4WklTVG44WUVNQXdxaXBiam93SkVCV0FPbWtGZWtPaCtwek5zWWp1?=
 =?utf-8?B?enJObkpRMmpST25ybXNpbGc4aHdqa0JkVStGeVdBWlV1Z2tnall4eGF4MCt0?=
 =?utf-8?B?bXFwS2M4QzJiOXZvQXR4bjV4VW9OZ3BGbzZQczVxemJaNW5GdGtsWkFxWG5X?=
 =?utf-8?B?dUxUdDJJdmJXcFk0L0JoME5KaSs2WHRnZmdzQ01jR2VqekxSbmpSSHBkdm13?=
 =?utf-8?B?K3EvRkZlYnkvbUUyeVZjZkVUVDlMRStPNjNLSmRBZVhGNjVQSEpxVjBLMFUv?=
 =?utf-8?B?eXBKM2t2ZysvM01OKzJ5c3M5QjRpT3lLRGhOMzQrTE5ybVcyNklmZkRyVzVw?=
 =?utf-8?B?enZZYXNyZ3IrMTBuSWtaSWxBdk83QW91QjVMR1pPQmRxdSttZnU0T0h1Q2c0?=
 =?utf-8?B?TGc0eDBxSm1oSk1OMFUvRzF4VE16dVpkd01UM0szL0Zadk44NHlvbkI1S2Jj?=
 =?utf-8?B?M2VqbWE1VzB2SVprWlFqOWlqTzBtc1YxdFozTXZ2V3NtUk9IZUZ2TkhYUTQ5?=
 =?utf-8?B?Unk2bGl0ZVZha1BBMnFSVVRZbVVEdEJ3aDhoT1BOOXNxTXMxQ3I1SEdlTnEy?=
 =?utf-8?B?WmU2UXZhRmRENDBWL002T2l1cEVOdkFsMVFXSG11c0xQK1l0YnhUZ1Nidlla?=
 =?utf-8?B?SmtWZ0JxVThHaWF0SHJvcE9IeHV3UGdjRWV1bGxzU1RxN1NOYTFLTVZ3eDZ1?=
 =?utf-8?B?OUdGdzFac0pNQVdHRmowRHRsZDlqRTR4ZnJGcXFpRmxLb0c3bEZtbnJ1NFZK?=
 =?utf-8?B?b3hMUG5hYzlBWThlcGtqWXlKTWtrZjFwRVVjOFBicWdhYkdsUXRocVBSNEtQ?=
 =?utf-8?B?OVF2VGRDOW1WaVRoMW83YVRLQ0FGWTR6dnlQaHNYRUpRcys2UnliSVd0eHlh?=
 =?utf-8?B?SmNobFJUNlp6ZlBsOW5WOHdlMGR3M0MzSSt5WElXbHhwZ1lDR0g5TXVjQjNh?=
 =?utf-8?B?MUY1MTh6USs3bkxGanBWZjJleGRwRmlWYzRlaDUraTljcE0zV0FkZTFST1JO?=
 =?utf-8?B?RFpjU1VBenNRWkVlRzYvUzJGQTl3MzhrcXlUZmVEdVZ5M1FZblNpNldRdHVT?=
 =?utf-8?B?OWRMdTlFOEp5YUZIbkY2S1hKRWxpYloxMURpTzAxU0l0eTFEa2h1dklIZFRp?=
 =?utf-8?Q?N95POk72N7USScU+/zQ+6H8eQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10992e59-cfd4-4f19-9b6c-08dc1b65fce4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 16:20:03.2765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKL4Tcds7jnw5VkGHBqeFuYq8/1APFlu2HlVm4EnenDQE6U5OZXCy91OR7r/yJgkPY7hw57LvW20qQgSrMMI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7143
X-OriginatorOrg: intel.com



On 1/19/24 17:35, Dan Williams wrote:
> Dave Jiang wrote:
>> Refactor the common code of combining coordinates in order to reduce code.
>> Create a new function cxl_cooordinates_combine() it combine two 'struct
>> access_coordinate'.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/core/cdat.c |   32 +++++++++++++++++++++++---------
>>  drivers/cxl/core/port.c |   18 ++----------------
>>  drivers/cxl/cxl.h       |    4 ++++
>>  3 files changed, 29 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index cd84d87f597a..4d542627d02d 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -183,15 +183,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>>  	xa_for_each(dsmas_xa, index, dent) {
>>  		int qos_class;
>>  
>> -		dent->coord.read_latency = dent->coord.read_latency +
>> -					   c.read_latency;
>> -		dent->coord.write_latency = dent->coord.write_latency +
>> -					    c.write_latency;
>> -		dent->coord.read_bandwidth = min_t(int, c.read_bandwidth,
>> -						   dent->coord.read_bandwidth);
>> -		dent->coord.write_bandwidth = min_t(int, c.write_bandwidth,
>> -						    dent->coord.write_bandwidth);
>> -
>> +		cxl_coordinates_combine(&dent->coord, &dent->coord, &c);
>>  		dent->entries = 1;
>>  		rc = cxl_root->ops->qos_class(root_port, &dent->coord, 1, &qos_class);
>>  		if (rc != 1)
>> @@ -514,4 +506,26 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_switch_parse_cdat, CXL);
>>  
>> +/**
>> + * cxl_coordinates_combine - Combine the two input coordinates into the first
>> + *
>> + * @c1: first coordinate, to be written to
>> + * @c2: second coordinate
>> + */
>> +void cxl_coordinates_combine(struct access_coordinate *out,
>> +			     struct access_coordinate *c1,
>> +			     struct access_coordinate *c2)
>> +{
>> +		if (c2->write_bandwidth)
>> +			out->write_bandwidth = min(c1->write_bandwidth,
>> +						   c2->write_bandwidth);
>> +		out->write_latency = c1->write_latency + c2->write_latency;
>> +
>> +		if (c2->read_bandwidth)
>> +			out->read_bandwidth = min(c1->read_bandwidth,
>> +						  c2->read_bandwidth);
>> +		out->read_latency = c1->read_latency + c2->read_latency;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_coordinates_combine, CXL);
> 
> There is no need for EXPORT_SYMBOL() when the definition and the only
> caller exist within the same compilation unit, cxl_core.o.
> 
> However, given there is nothing "CXL" about this function it likely wants
> to move out of cxl_core.o if another caller ever arrives.

It's mostly used by core/cdat.c but eventually also used by core/port.c. So it's all within the core. 
> 

