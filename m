Return-Path: <linux-acpi+bounces-7878-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A14E96132B
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 17:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACFEF1F21622
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FAC1C6F67;
	Tue, 27 Aug 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eLc9GRlT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F41BC9FE;
	Tue, 27 Aug 2024 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773457; cv=fail; b=umCz40yHlyBCGVFDtvzuNT1JbxKOsYSVqxYY4zBjE5EAPWxkdlcHHit0p1moSuTNPuX5PsslPMQ9knD90IMnvcDy8gfhrYvybspiIZTkIGuOeLTEdspHQVoD/R9RqO8GPV2s06FfpVbWXE0j6Naa8VRp0nqcaplVBwSnuskR4PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773457; c=relaxed/simple;
	bh=ApH8ngzP6C7oymVNpUfQ84uFV5sByUHr9WDb6HF/FBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tiTqmmtwJZxCheXf/EUJsy79ixmX2oaGXgFwdsYXxWPjHf3/FAci/uz77WvdkJhkCzlqQHDWdzM/Wk9acGaycBLE+Xxq7M8ufFKUcj9IMNvoCcgjpbG3Ld1kXUpsOQpAHDFXObe37rFvtWiU5ybhmhUZMXFTTg3+F5OK0FVpCmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eLc9GRlT; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ff4kK9Qb3/LWlmYUQM+bOCzKg+1fIlZTjwdt2ZIsQS2hzdYNtC6XSzjd79Lp9C8KvSiSDe8T5G20NF9LSBG1Ky1Pszxnyb7ZES1QlGwCxtZ7EsFd25VIYpie6YcPnFcuOHZd9JeZXc61Yt7KIgAE1E7GNcjedUr418U+JXKbvgPkb0eNok9TOZ6ZnqYqn1O+1mpHHbKHMNcZonylaEk1oAZZ8c6aCi343k3sFZ8dPFoercVFnf3crj91YSS87jdTkflcKRV8j69/gGuObdpjON+jZqc5AJRCdfT4PeYT3lBok8cZcRd4MqeQq9pM8FaebZu2N0pK/x9TKCpaEVO/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N50vTO3KGMwsRWnpu1b/VXe4BZO+Iy6BEnNe8kyWLCs=;
 b=WnsSnmabOcCcTsVEqtuswWmSLG2aHgX/84mQc9874BuIYGOq4uA7zKHFJcPJ2hurmwMrYm2aPbFKwhFfH6V/XenlZ2AEGPZ1oeptKSQap/5jg2MagUfTYAMnBzWP578ga0AOy/CZBdX30UtzjrN96zD3QsSv6yIpCJXWjaUfPG2ozNOK2apP3aYD26dyxZrZA23A6LZDW0OnSCz+QOyiMrQ5cEP7VgrEUnkJvVXQkyJQ17o+KYWXwdouGRUaHPVfZxfdgB86dSpCpa3NwseqsfPVef6GzA9TFtgPQi+4HNnnc9pLfpMpjqpS/0xGS6SacjZkyQplgAWxqRE2Z51yCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N50vTO3KGMwsRWnpu1b/VXe4BZO+Iy6BEnNe8kyWLCs=;
 b=eLc9GRlT9bk6m3n0rn9qxiRN30DLvArylkO/fJQ2HXMgwedShru3PcLWs8+EKQNMxpeCXqMy6DLhifDgyBa/0SdC26fOC8DoQ85RDxvTCDaEO1p5gPBG0pYoyu8QlozXsz/fd9eY+AcOGN5FjRX8AbxTpUB2n4dlfuJnVv6Z3Ac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Tue, 27 Aug 2024 15:44:11 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 15:44:11 +0000
Date: Tue, 27 Aug 2024 21:13:59 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 5/8] x86/amd: Detect preferred cores in
 amd_get_boost_ratio_numerator()
Message-ID: <Zs30P9EThSvLLZg5@BLRRASHENOY1.amd.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-6-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826211358.2694603-6-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::17) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 3676dd4f-e1ba-4924-24e4-08dcc6af181f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/GYCuj9U2CTgV6DCfgURR55qUhIg3nHk6BW6XBo2NGsf1TmJosGv4QeruvKK?=
 =?us-ascii?Q?Of/BwwF9uuKjZGxZdPGUtf00l+NmklfIt4gV7Vvm59cH3qy2L5IMxxUcjzUo?=
 =?us-ascii?Q?ezPeweNy1Oj0pJUAL3mLqxRXPxPLResn3BjKIK3ZKPZF3M+QI9gyMm22ZtVV?=
 =?us-ascii?Q?dAYiTm0kk9l6CunJqospduxZW+k2AQ7LfZS+jD2VN+xm5uLJkytltbPgcndG?=
 =?us-ascii?Q?0mP4CR+VykOJ0nr2GVvdAQFCA9RAxLNHqBvu6cCW8hD9SnIBxzq5Zvjc/Dlu?=
 =?us-ascii?Q?skWnm/MIDBeHzupSOU6JGdtY2QxtbsgFM1CPeWLJsEqT25iit4gesyJxYZBU?=
 =?us-ascii?Q?GyS0D88020refJkufjjZe3E8dgS4i4uhWxP3hNxPl9OJAO4Cc8MeNlOgnBGz?=
 =?us-ascii?Q?PdE+bG9W5OSCR19O0fA2DH7kc3fQ47bCnhqeJY+xOol88k1fvVERt238KcnE?=
 =?us-ascii?Q?Vp//EMOHYjo9LJHBC57cXS7Ah8CET7RPcqp/R0SqP1bPnDEExapRsqdmoYvo?=
 =?us-ascii?Q?M4LtFCI4/hP1uwOWL4b+njK+fb4UV3Z3DAMEyqh9z2exML8ufjWowX7sjc4D?=
 =?us-ascii?Q?IS8EFOg60mszcXfvh05WLkwXzExtODYH0Cyi9ytl9S/BVlCN10pmKeQKFvVu?=
 =?us-ascii?Q?sJ2PKuFxu5d/ocxZ89pd4ylBujSPLz7/xB12g9Z9GV+NQd5+axXsnRl3nHPo?=
 =?us-ascii?Q?ki1RqVlHOA+y2xfnURyyHNQeaWVLh7fKoqCB+UzmypuFaUdNqR8QPtxK5O6Q?=
 =?us-ascii?Q?7aM2Z1rBFrEIBBRm1MEjWbZEh7J3D5geNN1EgrPbTG0OSjUwCChYn7jVK1BC?=
 =?us-ascii?Q?XfvwiVsAzUF9uNq4WoFS5V2ck65SN81ymksTrBVJvpUf8pL8M6Y5qM7in9/y?=
 =?us-ascii?Q?tvPrcPJf3vChDatjfmE4zAqggLUGDJdaEaAVfCa8iOh2KmF+nfpJrGRLzGVw?=
 =?us-ascii?Q?cgblPXYxdonZoe18nKtg3U2SuMAYmpFLNK5Kjr31u2I5sZ/gPXcjmo6PIgYe?=
 =?us-ascii?Q?ckDg7RxpS1I/WIKKQGQbtBtNlXwC3/mjwP9KleFf0w38/P5UMGPATKXb45jp?=
 =?us-ascii?Q?/IY5HQHNzFurOySGAr+y20E1DA+QjjHV7+q2Nfup/KnZJX6Iyu0aJbd2KFaj?=
 =?us-ascii?Q?Pr8iyH19gkCvfW+xK+HqtV4nFttnTqFQZBaPhGsSi26UUZsbuawG/wlzARw3?=
 =?us-ascii?Q?Ml/UpS2VRgt+21a7Cb6W2HoD51t7v4dIL7O7uFaeVeXUCHrQr5vsXJ6fGMcP?=
 =?us-ascii?Q?6t0y/BzuFMQiy79CyRfLhiq07Gj+92eKzr/a4OU2vTDonIfLvJZ2gBd20pZC?=
 =?us-ascii?Q?Cy987cxgbgaES092xLCxho2NpCtalBe3SbVFpX4E0Sj6lQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FYjPFPSjiFZHX7rW3My/p5+5g/GQZARtB8Emu5GuJTI521ndpj3B+KuzCtua?=
 =?us-ascii?Q?8VcOR7lFyFMFy4hmFBxKVzz+fprKhQe9ZxkSraG0cwqoVGSBmjoCuLovc6xp?=
 =?us-ascii?Q?rMPsPBx9+IbH/geR0cIBbHADBnYIe5BKncKB+D8sT5dDDG/iBlMkXVMqpU1q?=
 =?us-ascii?Q?CHyxZvEYXm7zGX70FH4rTaWQu7ZEKUxlBpxG5bAvXcoRHqFyUnWnXpfpauwr?=
 =?us-ascii?Q?hBS+a1YDixTP+B5VfBEMaK6e29lYwtRrfBlddr+WsQHML9Gy27InkYgTDy2C?=
 =?us-ascii?Q?U20sVJNe1RPXgOY8FEqSpBF3PtbziK3mmimPWxVfxKliQL+IIeYnANCTZQLR?=
 =?us-ascii?Q?4Hkj/4QoEQF36ffJxGJ2gaLgmc7CV6EOgZmN1BMWO3CoqmWkfnFOKr8SAxTK?=
 =?us-ascii?Q?tA434LEOjfMOnQ6z+3RqMD/4al6jWNoVpHaR50TCZkVDMmL8icp1Mq0PE/aX?=
 =?us-ascii?Q?Sf7vqoH28ZO7mhnphnZB5ZeSopG+zOwx1bGt02ZEfOvAe5dhnAcY3htC7bd6?=
 =?us-ascii?Q?4Af184wD9ph31w5RBJSnpAt9/OrvBNXJ/D8UzEtcBlrd2VqzFmssjdf2wgz9?=
 =?us-ascii?Q?IsRxAqudH1szfpKrLzy0c34LHPj3abhKi3djHjLDYPPjkCriwSwJA1zLmfxy?=
 =?us-ascii?Q?AnkzRCOzkULECF1ObyN+sbi5hoSHMb7GZae4aHXxwofPt1xKl0CsysGAw4M7?=
 =?us-ascii?Q?Q55xuBcbhlzIHsHeLjyJoemRJvMJTLBPts2IkXrvoJ2pXPUL3KbkX4nQmYIu?=
 =?us-ascii?Q?GxhStBMl9vNsfmfefbVoiTVhTHs/XCKTLB/2pgaOoN/BNemhuaxu4IQbfJWB?=
 =?us-ascii?Q?gT8sW7rq21eGaSdo8N9trpkUucYzpcmKO9DU+NX4CzOn4zv2l3tnIDWHUq+F?=
 =?us-ascii?Q?VOhO85tGAs0f6oshS0EEZL2TA4wRT1VDQb5Jx87uJe4z1ZQNh6ghfY8LoXZe?=
 =?us-ascii?Q?Ajc1u6v1834cFc/lEaMlZn8SdUet9WnNOn3ANVhPmAH3dqp5zGIV2oIQy+bw?=
 =?us-ascii?Q?jXCYd5zGjhrLbh5QPtc3OWnyC+uvXhO1ty36brPsZilg6hlhU/PAFh0l02ef?=
 =?us-ascii?Q?pXQHsISBnhZ+5CC5CVEVZXROFMVJH+R76E7e+vex4JIjA38GLeyWFfu/mEHW?=
 =?us-ascii?Q?SLrXCfYnE+7ObG0d9Ti14c7Kp17eSdBc1xuOn7Q6qEKr7I/fj/4br6tg8D6X?=
 =?us-ascii?Q?MKT7oMM7nfHl7flWIZCFO1GcF/LIowk4sSLnakxhwEBYJ1uNWyl3pucrp2GZ?=
 =?us-ascii?Q?DTt3fHkeW0kqvAOo12x7Wk76FKs5z3CNwQxecjxhHYhQzKCvpb0FbrPSjnFd?=
 =?us-ascii?Q?Ncsns20VHUonSPlrIA1MXGG/o5E2PQfqPTmoWQLV6x2qmVtq6h4dediukDPg?=
 =?us-ascii?Q?WZwhvsUGFjXrsdiinwxCW4FpltwrlgCND3id68D/3WnL0hU2p/r3v5wfRcL6?=
 =?us-ascii?Q?T7K2Tzsq1fG8yLj3Ik6OOWwPE9+D4zmGpdchI0emorD5j8cXPQ3MZWfONtXT?=
 =?us-ascii?Q?mm+AlnUrT9nRUKbCiuGx02w4e3mTbAInp97AsmVMmL+mtm7Yi07AKfbCy2uS?=
 =?us-ascii?Q?Jw/77TZcZ07mgXhKxkbzebZvdAW8+lFCfdIA3c21?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3676dd4f-e1ba-4924-24e4-08dcc6af181f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:44:11.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnqcNFFPp5KBWVgjN73slQgkMF2aBCwqgGqJP1JdU7/eexqvJ42eO8ShGwbV/5EMx115hzbSnU6lE31fGXS0Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434


On Mon, Aug 26, 2024 at 04:13:55PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> AMD systems that support preferred cores will use "166" as their
> numerator for max frequency calculations instead of "255".
> 
> Add a function for detecting preferred cores by looking at the
> highest perf value on all cores.
> 
> If preferred cores are enabled return 166 and if disabled the
> value in the highest perf register. As the function will be called
> multiple times, cache the values for the boost numerator and if
> preferred cores will be enabled in global variables.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

[..snip..]

>  /**
>   * amd_get_boost_ratio_numerator: Get the numerator to use for boost ratio calculation
>   * @cpu: CPU to get numerator for.
> @@ -162,20 +232,19 @@ EXPORT_SYMBOL_GPL(amd_get_highest_perf);
>   */
>  int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>  {
> -	struct cpuinfo_x86 *c = &boot_cpu_data;
> +	bool prefcore;
> +	int ret;
>  
> -	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
> -			       (c->x86_model >= 0x70 && c->x86_model < 0x80))) {
> -		*numerator = 166;
> -		return 0;
> -	}
> +	ret = amd_detect_prefcore(&prefcore);
> +	if (ret)
> +		return ret;
>  
> -	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
> -			       (c->x86_model >= 0x40 && c->x86_model < 0x70))) {
> -		*numerator = 166;
> +	/* without preferred cores, return the highest perf register value */
> +	if (!prefcore) {
> +		*numerator = boost_numerator;
>  		return 0;
>  	}
> -	*numerator = 255;
> +	*numerator = CPPC_HIGHEST_PERF_PREFCORE;


Interesting. So even when the user boots a system that supports
preferred-cores with "amd_preferred=disable",
amd_get_boost_ratio_numerator() will return CPPC_HIGHEST_PERF_PREFCORE
as the call prefcore == true here.

I suppose that is as intended, since even though the user may not want
to use the preferred core logic for task-scheduling/load-balancing,
the numerator for the boost-ratio is purely dependent on the h/w
capability.

Is this understanding correct? If so, can this be included as a
comment in the code ?

The rest of the patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.



>  
>  	return 0;
>  }
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f470b5700db58..ec32c830abc1d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -807,32 +807,18 @@ static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
>  
>  static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>  {
> -	int ret, prio;
> -	u32 highest_perf;
> -
> -	ret = amd_get_highest_perf(cpudata->cpu, &highest_perf);
> -	if (ret)
> +	/* user disabled or not detected */
> +	if (!amd_pstate_prefcore)
>  		return;
>  
>  	cpudata->hw_prefcore = true;
> -	/* check if CPPC preferred core feature is enabled*/
> -	if (highest_perf < CPPC_MAX_PERF)
> -		prio = (int)highest_perf;
> -	else {
> -		pr_debug("AMD CPPC preferred core is unsupported!\n");
> -		cpudata->hw_prefcore = false;
> -		return;
> -	}
> -
> -	if (!amd_pstate_prefcore)
> -		return;
>  
>  	/*
>  	 * The priorities can be set regardless of whether or not
>  	 * sched_set_itmt_support(true) has been called and it is valid to
>  	 * update them at any time after it has been called.
>  	 */
> -	sched_set_itmt_core_prio(prio, cpudata->cpu);
> +	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->highest_perf), cpudata->cpu);
>  
>  	schedule_work(&sched_prefcore_work);
>  }
> @@ -998,12 +984,12 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	cpudata->cpu = policy->cpu;
>  
> -	amd_pstate_init_prefcore(cpudata);
> -
>  	ret = amd_pstate_init_perf(cpudata);
>  	if (ret)
>  		goto free_cpudata1;
>  
> +	amd_pstate_init_prefcore(cpudata);
> +
>  	ret = amd_pstate_init_freq(cpudata);
>  	if (ret)
>  		goto free_cpudata1;
> @@ -1453,12 +1439,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	cpudata->cpu = policy->cpu;
>  	cpudata->epp_policy = 0;
>  
> -	amd_pstate_init_prefcore(cpudata);
> -
>  	ret = amd_pstate_init_perf(cpudata);
>  	if (ret)
>  		goto free_cpudata1;
>  
> +	amd_pstate_init_prefcore(cpudata);
> +
>  	ret = amd_pstate_init_freq(cpudata);
>  	if (ret)
>  		goto free_cpudata1;
> @@ -1903,6 +1889,12 @@ static int __init amd_pstate_init(void)
>  		static_call_update(amd_pstate_update_perf, cppc_update_perf);
>  	}
>  
> +	if (amd_pstate_prefcore) {
> +		ret = amd_detect_prefcore(&amd_pstate_prefcore);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/* enable amd pstate feature */
>  	ret = amd_pstate_enable(true);
>  	if (ret) {
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 2246ce0630362..1d79320a23490 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -137,10 +137,12 @@ struct cppc_cpudata {
>  };
>  
>  #ifdef CONFIG_CPU_SUP_AMD
> +extern int amd_detect_prefcore(bool *detected);
>  extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>  extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>  #else /* !CONFIG_CPU_SUP_AMD */
>  static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf) { return -ENODEV; }
> +static inline int amd_detect_prefcore(bool *detected) { return -ENODEV; }
>  static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator) { return -ENODEV; }
>  #endif /* !CONFIG_CPU_SUP_AMD */
>  
> -- 
> 2.43.0
> 

