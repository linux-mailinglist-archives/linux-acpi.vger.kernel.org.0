Return-Path: <linux-acpi+bounces-546-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70437BE995
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 20:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BAFC28185B
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 18:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0D03B281
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hzGaBxNX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38891B264
	for <linux-acpi@vger.kernel.org>; Mon,  9 Oct 2023 17:29:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9092A3;
	Mon,  9 Oct 2023 10:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOBVnFI13+us4xi5UOjXdKDyOMI2AhLleKOWQNIKfSHLffpFuxoJ0LQd5iARLQ9t1s1fdkerbybEu4e6lUghmJG1aF8FJFG6kVItxJiWgDE+3a5nEFzd/uQLclytzt4G7Hub0Ces33HzcdjoK6Ap+GzAxFyQYZgG8tv0HcsExxDcN1Q35tU5Co+InDzBMcqlYOPvDWD1rPev73/0vHsVUnBA8lSykEiuBebktmga+E9TRuh1r8xnMLuZYEUgBe3eYusnWt6lDiXLYM0zBg8f3qgau0TfgrZ/+HfKBY5PtAJZAQo7j+8U9S9l6wwWtOOHmOWUyxlCQuEXVb/GC0Jivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+N3Bx4Lm8RVHu/hM+6+d0+tEplpSS0TRbsrv0qy3WU=;
 b=Bpnk8EvFBh/Oz81S+pnYEVcYmN0ofoyTrQ/daezQf4uhoIELrfu1NULnoZi7PWpEbQPEgn4eiAZiQy6BoBYhLUtaUXivHYla9UHYt3o4Dl/cNo1gbixJ+tvitZjVISMReWLa88uxkF7ufqjhOs1gr0ijHSBoSf63qiJHz/EzFzYHill6ftmoZKe5bDv/QIUxv8wTzlcJpcdHtj32HDa+1m7sknXCO9aYP8xkM/KH0n9WgPrQlUHra53zP7qqDYcLFPzx4SNr05C2WBmLdDLqzEf4fskfVtWR/SO+xqJrGSI76hEWdXpdE44WEfNWRJPPBMBbL+arFOGUiBvzcoLpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+N3Bx4Lm8RVHu/hM+6+d0+tEplpSS0TRbsrv0qy3WU=;
 b=hzGaBxNX87pqjNpLthmIByTUMX3oYpC3Xxhz7HyYwrlYGd7fx1dmcPjGlxv5zcWzHo1xvaoAe3O0z3lXD6YaCsaf+n3ZWcBH3urBs/QyCpcd7QIqpf6ef8qS+rnVgNXThFlPEanVLMZK+MKFgdycKp4csQQMfRBLoCtuo+eya9lJEqgT7RuBv3X0UpmdR7Rh541RgH409MB64ejNr6ixEWSUxEo2iZdGDMBeMVDtCGqzrJKCbe/5k5uWESOb8IGTUqR8upDrDVJg0YbEm5sw2Yn6RLJW0Gv5Zzx1VtwjiZEE4Io7XKd5nVK9S1WoBqGR2JTNUHov3fqTOgt92u6Xag==
Received: from SN7P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::18)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Mon, 9 Oct 2023 17:29:17 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:123:cafe::25) by SN7P220CA0013.outlook.office365.com
 (2603:10b6:806:123::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 17:29:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 17:29:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 10:29:04 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 10:29:00 -0700
Message-ID: <73439457-2863-5658-6e2d-5fc75ca43478@nvidia.com>
Date: Mon, 9 Oct 2023 22:58:57 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v3 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <rui.zhang@intel.com>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<bbasu@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
	<srikars@nvidia.com>, <jbrasen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20231006153612.5851-1-sumitg@nvidia.com>
 <20231006153612.5851-3-sumitg@nvidia.com>
 <CAJZ5v0gneBtF8-cwMEtNAA2jBjQxzEc4N4feLDk70rngTSAOaw@mail.gmail.com>
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0gneBtF8-cwMEtNAA2jBjQxzEc4N4feLDk70rngTSAOaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbec335-732a-4646-e773-08dbc8ed4379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fWLMvzMxWYsj5dXdo5moNAYsQFnkwT0IZx15ZIVffjI30bgxZH9vb5bKGFOuCVUMCo0wYKc5XyKt7iVEQAyfeAW+o40jTJSg24cy+v2AasqlbyoMJW0ffA8t6gXmMFgbtaO5Vn2jy0ppC+6SH2DXI192ZLkb6ZjiIKFyInVw2FQlwRH0ihLwkNjWGFolfuzTmNnuHA75RkKq9wGkupG8d10nNCOYeWVV4ECjjSh/8X8u9BWgrk5CJ031YqlVOkQBRl5roZmZF9kskA6wKaWPGKfb8ohLwUxpspuGKJP8+m4O5Q+2YRDh5gnRPGJ3+/6nuqBgBQS5DCV7xjITZfNUj7Ob7PWir1fpQ1VLIkjmbDQqYtkeyyX7VBWnp3pdCkqWpLHkkE7hHTjvFaqkqHpUKc50ZbBlHh+CWFXYtwhcZFPGMNWzqdnOxQHrxBL4d5WKX1sfLBM1gdlaszkjTTgmpdJ3oaH4uPpNwI/GtYMnPbf8xRrZQQZhTn1X0t0j7DcCBsUhmd04GwDkqRKi/AGMajS11iSZIsXWoyfRTkiZeCp9DNrkeEHjXqH+pcfhMIvFcfqgDqMKyxLfWLIYgbziouBjfTo5dS5iU5YuAQ+osNAaY1EhxEx+hGeUWyRQa/ZHJg8gjNGYTVrXPhV9LYXfD6JZKv46EmjxPVsz9sGaM6AQHTJHg+H0WPzcC7NSF7mF9KCehe3Ly/rE4pO6uJV4g+ftG2AB0ED3zEUXFLlG+Cy34M7ueB+kXR7O2W8HEkK53WbBzOnu1nwyZquOx8JeS7nREHOkNi0klXGQim3xvLu8l8ybEShsf3MBbHNtu9/I
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(83380400001)(107886003)(6666004)(16526019)(26005)(82740400003)(2616005)(7636003)(356005)(966005)(70586007)(41300700001)(47076005)(31686004)(336012)(53546011)(426003)(478600001)(316002)(16576012)(70206006)(6916009)(54906003)(36860700001)(5660300002)(8936002)(86362001)(4326008)(31696002)(40480700001)(36756003)(8676002)(40460700003)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 17:29:16.6361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbec335-732a-4646-e773-08dbc8ed4379
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 06/10/23 21:22, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Oct 6, 2023 at 5:36 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>>
>> From: Srikar Srimath Tirumala <srikars@nvidia.com>
>>
>> Current implementation of processor_thermal performs software throttling
>> in fixed steps of "20%" which can be too coarse for some platforms.
>> We observed some performance gain after reducing the throttle percentage.
>> Change the CPUFREQ thermal reduction percentage and maximum thermal steps
>> to be configurable. Also, update the default values of both for Nvidia
>> Tegra241 (Grace) SoC. The thermal reduction percentage is reduced to "5%"
>> and accordingly the maximum number of thermal steps are increased as they
>> are derived from the reduction percentage.
>>
>> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/processor_thermal.c | 43 +++++++++++++++++++++++++++++---
>>   1 file changed, 40 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
>> index b7c6287eccca..677ba8bc3fbc 100644
>> --- a/drivers/acpi/processor_thermal.c
>> +++ b/drivers/acpi/processor_thermal.c
>> @@ -26,7 +26,16 @@
>>    */
>>
>>   #define CPUFREQ_THERMAL_MIN_STEP 0
>> -#define CPUFREQ_THERMAL_MAX_STEP 3
>> +
>> +static int cpufreq_thermal_max_step __read_mostly = 3;
>> +
>> +/*
>> + * Minimum throttle percentage for processor_thermal cooling device.
>> + * The processor_thermal driver uses it to calculate the percentage amount by
>> + * which cpu frequency must be reduced for each cooling state. This is also used
>> + * to calculate the maximum number of throttling steps or cooling states.
>> + */
>> +static int cpufreq_thermal_pctg __read_mostly = 20;
>>
>>   static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
>>
>> @@ -71,7 +80,7 @@ static int cpufreq_get_max_state(unsigned int cpu)
>>          if (!cpu_has_cpufreq(cpu))
>>                  return 0;
>>
>> -       return CPUFREQ_THERMAL_MAX_STEP;
>> +       return cpufreq_thermal_max_step;
>>   }
>>
>>   static int cpufreq_get_cur_state(unsigned int cpu)
>> @@ -113,7 +122,8 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
>>                  if (!policy)
>>                          return -EINVAL;
>>
>> -               max_freq = (policy->cpuinfo.max_freq * (100 - reduction_pctg(i) * 20)) / 100;
>> +               max_freq = (policy->cpuinfo.max_freq *
>> +                           (100 - reduction_pctg(i) * cpufreq_thermal_pctg)) / 100;
>>
>>                  cpufreq_cpu_put(policy);
>>
>> @@ -126,10 +136,37 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
>>          return 0;
>>   }
>>
>> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>> +#define SMCCC_SOC_ID_T241      0x036b0241
>> +
>> +static void acpi_thermal_cpufreq_config_nvidia(void)
>> +{
>> +       s32 soc_id = arm_smccc_get_soc_id_version();
>> +
>> +       /* Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) */
>> +       if (soc_id < 0 || soc_id != SMCCC_SOC_ID_T241)
>> +               return;
>> +
>> +       /* Reduce the CPUFREQ Thermal reduction percentage to 5% */
>> +       cpufreq_thermal_pctg = 5;
>> +
>> +       /*
>> +        * Derive the MAX_STEP from minimum throttle percentage so that the reduction
>> +        * percentage doesn't end up becoming negative. Also, cap the MAX_STEP so that
>> +        * the CPU performance doesn't become 0.
>> +        */
>> +       cpufreq_thermal_max_step = (100 / cpufreq_thermal_pctg) - 1;
>> +}
> 
> Looks better now, but one more thing: This is introducing an
> ARM-specific piece of code into an otherwise generic file and there is
> drivers/acpi/arm64/ for ARM-specific code, so I would very much prefer
> this piece of code to go there.
> 
> Of course, it won't be able to modify the static variables directly
> then, but what if instead it defines functions to return the
> appropriate values?
> 
> The variables in question could be initialized with the help of those
> functions then.
> 

Hi Rafael,

Thank you for the review!

Have done the suggested change and sent v4[1].
Please suggest if it looks fine now (or) needs any further change.

[1] https://lore.kernel.org/lkml/20231009171839.12267-1-sumitg@nvidia.com/

Best Regards,
Sumit Gupta

>> +#else
>> +static inline void acpi_thermal_cpufreq_config_nvidia(void) {}
>> +#endif
>> +
>>   void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
>>   {
>>          unsigned int cpu;
>>
>> +       acpi_thermal_cpufreq_config_nvidia();
>> +
>>          for_each_cpu(cpu, policy->related_cpus) {
>>                  struct acpi_processor *pr = per_cpu(processors, cpu);
>>                  int ret;
>> --
>> 2.17.1
>>

