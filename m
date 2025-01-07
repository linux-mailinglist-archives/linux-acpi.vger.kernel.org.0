Return-Path: <linux-acpi+bounces-10415-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A083A0483E
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 18:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D767A38BB
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 17:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8901F5426;
	Tue,  7 Jan 2025 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wj0b63rv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9EB1F5400;
	Tue,  7 Jan 2025 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270893; cv=fail; b=FeChO9XgWL0fVoawxJ+78OjFKwocsYa9QV4vK+NbCfORqIzvCh0qsO1VCT1REOluG70wMHnedtb96aatO9DYRYjXJYCtnVqXppHvk1W7N7q/38VTEXeL58nSE9iFyXR+K+MOo9TX4jQxz4cVReTZP12SH4uLwkyxoeS5O5oM1Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270893; c=relaxed/simple;
	bh=k57lxjiWbSwTb1BfDOc7oiyDCbcPFBncJ7RlQtRBbLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SuRq55+CKyOG1lm606/UIE2dlWt6mn+oOq6mI6CHHDgg5G45piGzx+hsG0ZVkZSOEjOLlzKFZqabBjHZZXKfglJwq37e0uUXXqwZvsyNxLMl5yiicVBn2E5tVjGBVVF+Zq/aAXAxyeLRJFNU2rcVkty5oC9Ma7gc7oaL9g7LJ5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wj0b63rv; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WH3SSK/F5j9ZaVc0wdqEn1mXpf8FK6X6LP5TORANhu8FI00hViKs8Y1YvDB9467CZU5p+Zb2XNch3pHscHHQyYSkUgz2afTyZfN/jxssXHKiOdnRhqmpWBUjpmni2lUZCE2dHs7zqHc4RAQbHsO0tsALZ7MCKA01TxJdKP5BSVi95+P4QSBsof2g7GvvQ3T78hnfbqY/4iwNGjdIGxpTnBSjuwS7GVuBvMfB3q+1KsKhPt1yOKZnNL3ElsbIIqG9H460oqOScp5owCDpgtmuksL0M2KeJqPz9kzRw0U5SkOypy5js7xgz4eAxI9NpTRnRZyp3m1hDGbyWpo5p0i4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ti7c7IOge13TqcnRj1ERRdlq6D98TIsp04w3l2CNnhY=;
 b=wuVunTyyAnHZRv+90wKn9NICmojYH4xjKXT6EaGH9FdaG80xJPEXdLkcOno6m7cUj9C/paMg0kIZjQB9BqgSCo0TeUJbZvoj0JFFy5EqtRXOlhSKj7P4vUICWRi2j02WiTReHtCLNr8TiANwRjY+GyjUThRxwR+iPSe5fCaCcuhJca/TvW7vyoMGLBMkJxF4QlyH7Hj9iQ/d/o2SAm1fF+q6BNtYjXPIBlUJQqIVZIhXyQNBjRg8Cktc9LPCqCSgMRSKa+zolJnBJexrVRAbpFQmPRQlfv0Fh4XdZ30bin/Yd6sNvxbTK3G9GzhcMr14V5bMuWz1Gwbmy3H2CWkhOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ti7c7IOge13TqcnRj1ERRdlq6D98TIsp04w3l2CNnhY=;
 b=Wj0b63rvVTguddBQbymyOywLzrVO22CVczpOkTikJfsyxIR4PiEOmMhG3qsBwqKPkqB+BLVNfbDEFcZu2dZgiTw1A04wt62dVqaCQ3eaAQ68Ycrutx1bDGIlMd8xJ3+PSGqu2zeRtd9wZhOosK+pJGuxA8EnFf1ahh8g7vLmF+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 17:28:08 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Tue, 7 Jan 2025
 17:28:08 +0000
Message-ID: <4cbfaa44-5ba6-4ccd-8db6-e74af8fe4bba@amd.com>
Date: Tue, 7 Jan 2025 11:28:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] ACPI: platform_profile: Let drivers dynamically
 refresh choices
To: Kurt Borja <kuurtb@gmail.com>
Cc: Hridesh MG <hridesh699@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 josh@joshuagrisham.com, "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Armin Wolf <W_Armin@gmx.de>,
 Colin Ian King <colin.i.king@gmail.com>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250106044605.12494-1-kuurtb@gmail.com>
 <33a5b6a2-e4df-4bfc-88a9-a9e8309c7f7a@app.fastmail.com>
 <CALiyAonc81o1FreDaWiik3XaqKYVf=wYHX+vaE2_1w66LhJTnA@mail.gmail.com>
 <2e71a4a9-6ec6-4ac7-8640-d80dcdfd7776@amd.com>
 <CALiyAonp1eow2ht_Cmux0B5+-Ukx7YxsE59c4VzwfSvL61iQ5g@mail.gmail.com>
 <205c47ef-6651-4a57-bbe4-adf1b8a25983@amd.com>
 <zelin5tbkup26skhs3dwacwxl33h4ryzgrn3nefay7fxotb5v7@aumb6v7hexpc>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <zelin5tbkup26skhs3dwacwxl33h4ryzgrn3nefay7fxotb5v7@aumb6v7hexpc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::9) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 13835fee-41cd-4445-cfc6-08dd2f40a725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmFxVDRuai8vS1d0VXRxVENnaGYwRVFyeTJwelJFUkhGeWxDQU0yYXZNSHpC?=
 =?utf-8?B?V2QvVllodlliSXpEbFgrZDh3RjhHRUtCMHRQRHN5OVBwNzVndTJkM0dKQ0Yx?=
 =?utf-8?B?QlpLcHBwc0hKVkJnVzR5eis5cE1kQ1g5cVVqNlp3RnRJbWVOa2s3ZXFaNXdn?=
 =?utf-8?B?MFVtOGpxQTlJQks0UWNFMnpyczdIdTZOZ1VlY0FjelYxWU1uSWVPeVJnVzFI?=
 =?utf-8?B?UW1DYngrSVhpWmVCTjJrMW5TUXNOMlB1ZzNXQlVreWNoMmRMRHVIVjFoSStx?=
 =?utf-8?B?S1F5WnNHTlliOWtEbG9PV3gvK1c4ajMyQUpmWGJLbjFWNjYwangyS04zeE55?=
 =?utf-8?B?ZDhMVFA5UzRtcVhLdEp0WjYvTC91cWs1d3NTYnZqSnIzYWhySTF3UVNXaHlX?=
 =?utf-8?B?TThCZ2NqZUtjTE5SOUpydzhyY0ZLNU44NHgzbGZZdXpPZm1pYlBjTDhVSEky?=
 =?utf-8?B?U25NbldXcjVsU3VISnJMR2tpNkJtNDN2NTNmT1FIMllXRnB1Vll5ZkhNYTRv?=
 =?utf-8?B?U1lwSUVFMGlIQ3pPcnNUbDIxMWljY21LZ1Vmb01vc256YkR3ZGJyc1pxVld4?=
 =?utf-8?B?TUlrL244dWgwTUZDS2Y2YzhQNzdhck5WMTJPQUs1Y09PNkxVZTczdXVYMDl6?=
 =?utf-8?B?R2hIeWxOSVhDV1dKNUhGZ2d6NjdlMWNtMDBSU0VabjdLSEc3WXZSUG9CUG5B?=
 =?utf-8?B?a291NzVKdjlhZ3p0a0JmeWJVN01ZU2tadlhZcEZoSm9RN244d1E0YmxGUFdK?=
 =?utf-8?B?aFd2MUdvRTd4dGh3V1N4Q0VTWlZNcTh4QTYxazc2dXhjN1ZmSGNId2N4WGdq?=
 =?utf-8?B?aTJLZWcrVDEzZFhMaTVpNG1yUjNwem00ZmRqUTlUU1BmOCt0VE5SeVJ0ZkdK?=
 =?utf-8?B?NVNTNjB4UjA5V01NNTRaZmE3T0k2NTdxd1FNNDd1UEdBb2FGeWxIdUdlYkF5?=
 =?utf-8?B?RDIzaXBKdDVFZTFNSlBsNkhYeWEzODU4aklWZmxvRUpnZDJzTWFqNGlTLzFz?=
 =?utf-8?B?V29NUUYvZ1hqUWNnaHBzTmtWYmFHU2hlK3JkQm9VbEtpK20yWEhyWGR4YVZH?=
 =?utf-8?B?OHE3RFQ5VHhpckVNcGl4ZWpLVFdyZVM2VEJHQUoxYmw1cjRYREZNNjFGQWJK?=
 =?utf-8?B?SFBsb1BITWRISW1HYzNSRUp2ekRCUnloQUwvV291cXpLQnBKYVJKZ2g0cTVQ?=
 =?utf-8?B?ckFJTE5PYzN4cWc4aDJSdzZkK0VINVp2ck9rUjNOQk9sMjRWYjlZMWoyN1JJ?=
 =?utf-8?B?UjhYWVBVdXY1amRpWEtvM3hXVUxZek9DWUlwUHlwVDRTMDVPSWtBRlNFOE0x?=
 =?utf-8?B?NHkxbVh0Mi81OGtsYkN2bU5OanUvSlozUTlreTFteGhTZXBxS3VLbEtnUFdq?=
 =?utf-8?B?Z1NjcXkrbEFNVlFudkJEa2pMckxFSm9nSk9BNUdDajlpdkJZTVBYcjJ2clB6?=
 =?utf-8?B?eHFFSGtEL1BRMGRFY0NyR0JIZmluWVNGcTBlZ21FbS9Xbmh4TnlsWjNZbSs5?=
 =?utf-8?B?L25UV2NURW4xT1BYKzN3U213Nm1TbjNrUWhqdXdxZ21vKzYvRzhsL1hBNTV6?=
 =?utf-8?B?MS9KcWpSdWlrenZwWnRWLys5NmNCK2YwSVhvODJHZkRRZTlPa294Y2Z0Wmdi?=
 =?utf-8?B?WkRiTkRzaVdwbHZtZHZxRkYrNHZIRmRRajFNdVpkUGh6dFBjRndHME9yVlRW?=
 =?utf-8?B?ZlZKa0V2dHBQbmNXNit3ZGNyekNqcmh2bUtteThmWlNGSWpwdURWa2NZd2pi?=
 =?utf-8?B?QkxnOGhIZXVzbVA0b29veWVnWUF2dDRrV2VNWFF0Q3NPYzFnTFZPTmNNT21q?=
 =?utf-8?B?ZzQ0VlFRenZPL2xtSUhybXRWdjlVb3RPS2xMMytsWkdrdHRDY2pPakFTSlVx?=
 =?utf-8?Q?mr0QKfF3R/rvZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mjd2K2xlV2tIcXJJUUk1NXVwOFZTS05DWFFlYU1GeERHdTh5VGtqaDNEaUtm?=
 =?utf-8?B?TGR3Mkd1aTR6OUQ0R1FHRmErdlRvU3d1MjIxczJicG9TTUZIZWNSVU9ZS2s4?=
 =?utf-8?B?QmV3TXRKR1NyS3NXSktVSXl6ZDh0VTdteVE3dnFBMVJwTjNUeGdxZ05QbGZM?=
 =?utf-8?B?eGxrQVNsdUFNekxTSUlZZkRDd0lQdlBQQ1d6QWRXUWltOWxPYm5BU2VzSUFl?=
 =?utf-8?B?VzgvVnJyblBJekpObTJiWWp5TnJabzR4eHRqMm1aWFNhWnpCb1VuUnJFUGpr?=
 =?utf-8?B?RFZNWUl4UGg4ZjJLM1VNQVpLUWtVTjNXRGlhK1ZOcmhPK2x6RElqc2xxNjJP?=
 =?utf-8?B?YW5aVUV0RDRSaUd0Nk1rTU9peU85NU1Qak85QUNpakdLbUs2aDJHdmoxUkNr?=
 =?utf-8?B?eTZ4KysrVUhzTjBTV0lwSGV0VFJQbEdLc0VsbVdPRUlIOUF0N09aVC9aWDlk?=
 =?utf-8?B?Z0lTelFoWTRVa3FiaWREOFV0Smt3TmhQVHVubk84dzl3d1NhdDhSWXJBYXJj?=
 =?utf-8?B?elc4Vm5UM2Y0bXZFQnVIRWo5dWE4ZWZ2c2RRWVlLcTFDUEpDYm9XSkg1WVQw?=
 =?utf-8?B?Sm52WldPM1orM2dUNy9HK3JOSWlySFFZTmdONDlKdDd0SjFGa0lkZjJ1YTNw?=
 =?utf-8?B?ajZ4SVBSU20wYWdhRW9vSk5menJoNDZidmJOY29FVm5CQVpHenBmbkpnQ1B5?=
 =?utf-8?B?VjBxdTlkdWM1ckYxM3hQUjZQMVFwamRKdHp6WFIrNzdVYWR3UWxoNEdjdGxT?=
 =?utf-8?B?cFV0OU9WM0t1MjMzT1pKVEFsMTcxTXQyZE8xSkJRc3I1aVBFZ2h0bWllb0JN?=
 =?utf-8?B?dVp4NDQ5bTFPMVNmQ2h4YkowbkJvdjB4a3k0RHZURnJaSlRHeGJCWFE2RlM0?=
 =?utf-8?B?RWswdmE5RkxSQVB0ZEZUd1Y1RmV4VUxaZzFSMjJTbEVtaGlpU1lrSlVuUmxK?=
 =?utf-8?B?T29xZDlXT3lST1g0N1d3VHpVdUUxVjIzdmd5WnhQRjNmL3R4Qk1PZUU2amN3?=
 =?utf-8?B?ZnJUS1VRQklZT1RvTGR4RzJJdzN0bFk0b05rRkVjN01qNGJPbEk0ZFpReml1?=
 =?utf-8?B?N3dTcGdyeDNiTElVWjk3L3NDZ3hIVk00bzlFWUhxK0Z6YnA2M0tPdG1Ebjlw?=
 =?utf-8?B?cXJ3bDZFSUE4T25UVUhPbk10OEpvV0VFNkdNckliYzNXYVJyeDNxS1M0SUF2?=
 =?utf-8?B?QWxUMFlRcjltT0RkUFdLVXk2Q0hIMnEzR1k0eWw3T29nM3R5NXVYdjBaM2dy?=
 =?utf-8?B?TkdwVklnY1JDckRLbUNnaUVwZkFqci9RQW1PWW93a251c21mNjhBSTBtdnFq?=
 =?utf-8?B?NTcvZ21Ta2hLNitIN2R5TWoySWZqdXJDNEJzVHZ0V1JTUHlDcUNDYlpkNWVT?=
 =?utf-8?B?MFZEOUFiclhXZXd6TmFkV2Z1Qmdua1puUmpjQTEzNVBhaytzUk1mU2IwYXNz?=
 =?utf-8?B?K1p2d3VSN2VjU3A4d1lZWkN2SzJxYXRab2ZrTXRUM0EyR0VDYW5CczRFYTBK?=
 =?utf-8?B?aWlZOU04RG5GZWdicUdHbEEyTkpJWGVkMnBGK1VvRHlzTDU0TUdnUUU0dkhE?=
 =?utf-8?B?NkFRRzRDNHVnamt6MmFWWXZTVTZqYndTWDcwbFRMMytpUVcwZG5iMHpyM2Ns?=
 =?utf-8?B?dEF3ZERsMjZTbkJiUmQwOEl6b3AzU1l2aXRTOVVpMnRycEY1VkhodWV1dnk4?=
 =?utf-8?B?aHBaZThzZDB1OHd6Q0NseWcwQXBxQ0xRNldrR3diSG44bTg4RFErMGRpRkZk?=
 =?utf-8?B?cEhwc0tVL3N6d052eVpGbmxXVW9UYWZoZlg1RDU3SlJxSlo5K0M3dk1wZDdY?=
 =?utf-8?B?Rlk4cGhyYTBubXNCU1RadWlTNmR0VFhYdWJmRFMzTllVcFJ0WnMxNWN2L1ZR?=
 =?utf-8?B?bEVzK3NxMHNnNTBabXVoRi9pNVFjb3FMcEJBbnREZkUvS2g1SEhvU0lNS1J6?=
 =?utf-8?B?R2pEOSs0MUxIZFJxRmV6eVVVNmp1MEtYNVFmeDdMMVhLd2tzWS9LUTJXcG5M?=
 =?utf-8?B?M25wMEtCeXBTVmV0N1FyNnZIdkJvOTZKYUFNUCtDcVBXeEhoMk8yZUxETDFJ?=
 =?utf-8?B?TUtGVjBFVi8wUG9JYlJHcXh3OE5Xd2hHOVU0bnNqZ2ZjRXFzbzJYdWZySzAx?=
 =?utf-8?Q?QOaPjnKLW/ChcWButYJH3VFEw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13835fee-41cd-4445-cfc6-08dd2f40a725
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:28:08.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtAjlM/IQhH68ddMQACdeIQWR6CaiUXNQRreZoAtbWFOCyrThzWJQ5K9DRBsqkfwS0Q4NglwC+uHG8Xf7JoLaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934

> 
> After giving it some thought, I agree with you and Hridesh. Kernel
> should not limit profile choices if they *are* selectable.
> 
> If a "proof of concept" patch is still interesting I'll be glad to send
> it, otherwise I think my original idea has too many problems. User-space
> should be able to handle these special cases.
> 
> I think an attribute allowing/disallowing power sensitive values is
> interesting. Maybe allow users too attach/detach individual profiles
> from being selected/cycled? On that note, it would also be interesting to
> be able to detach invidivual "profile handlers" from the legacy
> `acpi_kobj`. But I'm not sure if this added complexity would be worth it.
> 
> Anyway.. Mario, do you think hiding platform_profile_handler from
> drivers is something worth pursuing? Similar to what the hwmon class
> does. I feel having some struct members like `minor` and `choices`
> exposed, or having the profile_get/profile_set callbacks not being
> const, while it's not the end of the world, could be problematic.

Yeah, I think this is still an interesting idea that's still worth pursuing.

Making the API simpler for drivers is a net benefit and reduction in tech
debt.


