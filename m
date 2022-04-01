Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2204EFA5A
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Apr 2022 21:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiDAT0i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Apr 2022 15:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiDAT0h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Apr 2022 15:26:37 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2882143469;
        Fri,  1 Apr 2022 12:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1648841085; i=@lenovo.com;
        bh=387nX6FDRXrs6qZmbWMoebF75s9mcq5a2YXVjeD4oY8=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=FMGom9vLcyFj/tAa+KP2S9uJewxvAbMuxNdN0vmfkpIXPUGjGinQ4YX92c1xfPFim
         +8UskBv7yUICvNNdmT3faHfLvtzfq3Nz/LxA4MgrYHbfM7GWbrYKs4UM0lGNznxMw9
         b0dFWOoY+l7gxQxMeKHQTDXPBrVknSnf08kH6QS4ifHykGaet/yvFp8v4vYjdMnDZz
         /lFEA+93ZhCrdC/1RiApcWMxTrC07EvZW8dBxb08ZpGnOIOzxblg1fJB9Ob+rBaVDM
         EmvZKrqKOII6HwT2KcgQZwkBFx/2laXlQaVM2ODyI6et5J5xU/Amr+ujnkk4U0gZl4
         lxcDmRmye918Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRWlGSWpSXmKPExsWSoS+lp1sZ6J5
  kcGqRtsXXb7fZLd4cn85ksXxfP6PF6j0vmC3OnL7EanF99nkmBzaP1kt/2Tx+bVvD4vF+31U2
  jy1X21k8Pm+SC2CNYs3MS8qvSGDNWPrtIHvBZeOKRSvMGxhXaXUxcnEwCixllli9+xcLhLOIV
  eLm/etMEE4nk8TkeffYQRwhgVlMEjNfbWHtYuQEcg4wSdzfnASSkBA4zijRfWgdE0RVJ6PEj1
  enWCCcfiaJIxefMEO0PGaUmPerCCLxkFFi37rvbCAJXgFbie0Xn7CA2CwCKhJTNk5hgYgLSpy
  cCREXFQiX6N6/H2y3sECWRNuju2C9zALiEreezGcCsdkEtCW2bPkFFhcRWMkoceNqNURNpcTk
  fZ1AcziAFhdIzGhPAwlzCthJfLn3lwWiRFOidftvdghbXmL72zlQNytL/Oo/D2ZLCChITL9xi
  BXCTpBonnKUEcKWlLh28wI7hC0rcfTsHLBVEgK+Ej8XFkCEdSWuvXgHVZ4jcf35OhYIW07iVO
  85pgmMurOQPDwLyWOzkFw3C8l1CxhZVjFaJhVlpmeU5CZm5ugaGhjoGhqa6JqZ65rqJVbpJuq
  VFuumJhaX6BrpJZYX66UWF+sVV+Ym56To5aWWbGIEJq6UImfWHYwfVvzUO8QoycGkJMo7V8k9
  SYgvKT+lMiOxOCO+qDQntfgQowwHh5IE71k/oJxgUWp6akVaZg4wicKkJTh4lER4pwUApXmLC
  xJzizPTIVKnGI05rmzbu5eZ49KhK3uZhVjy8vNSpcR5o0FKBUBKM0rz4AbBkvslRlkpYV5GBg
  YGIZ6C1KLczBJU+VeM4hyMSsK81iBTeDLzSuD2vQI6hQnoFP0briCnlCQipKQamOo+nzPysDU
  yjfzS3spyavZhPvtjR1xV95TfET3tqnUxK1hTcm5/yNQFDS93i1slMXxg3XWqts8tVFHZyIzv
  LKvFAwV+vQ+de5QvV65Tyo2O1NbO2bTQ5XZvf7gL40N2Y/6VHx6rFvktSng5Uyph3ddHOyVfr
  BNUOThp90Ntsa7FlR3TunuTHrF0cdfunPCZibXMgp2jpdfWQ1Vn+s1Jntdmntt49KX6vUPmdw
  pPB958a/V8MfOeqXKdc7dMXRac8CjlQlW5V9vuHO6yA62n7jQw5gT6yBaXv1rwc6qt6N69+5e
  vnSo8n//wPS7FdBvf7d6RhU3rOFateZn89rfOKhXrq+wrporYnp3aUnrughJLcUaioRZzUXEi
  AIHerExpBAAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-8.tower-635.messagelabs.com!1648841080!54284!1
X-Originating-IP: [104.47.26.46]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27784 invoked from network); 1 Apr 2022 19:24:41 -0000
Received: from mail-psaapc01lp2046.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) (104.47.26.46)
  by server-8.tower-635.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Apr 2022 19:24:41 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwiTQoW8zukFG4JAYYCZMTIjxaq/kd8ec0FV5WDpXhSrHBn/USzIMJmEDQUGoFMPeZMNqGJpkT3maAmxdxbo+A+xXVEd0xcBt/mEJynI6i48SCaoPdFN+MGYiWRGlQfE9FilJJsQ1hqxGwys/8VCF//ke7dxOYO6sk2OTUInykUD1Pl1pol3xeamVx5RCHuRam0zYN5Dz0FbczYRX9UZ7GS4KIdGJEqrRg2r1Mih9UXDR7LVrx2/PKJXbm5x0zu5AsMa0XxSbpGn9i8yjCX57KBVgffGmNii5YkjFTMNCUGddCL0Emk9xEcmyTyOrFZMVyL9bZo+o8eyWvYc4+KFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=387nX6FDRXrs6qZmbWMoebF75s9mcq5a2YXVjeD4oY8=;
 b=f66ridsdxQtVACbTJqxmwJJaNt64GkwiVdDRayOi1gtQgaowwsbj0bHHoMdObfpVwY6oLMzXlCmwccqX55lQ7SYKbtP4XKGRPv3p/YXylkyokS/JZmVlUsWVQegUqC8ZAhNl/KhXYNgZHob7m/AiqVdidb/QNN6YzrwU/Zy4qFll5gbrMMvtwnu1lCg993wvfL1hnVskQd7oia7sLyQjz8eIHVokj/7qTDoa+v7pRn9EHVUVQsZBmQdKxkhD5QJ78Og1iFgmoMaBgpwZEfc+VfUAvhz6roJAVwKmMIsSp1b4S1fP8P8Nl3PfFPllfoWZlzeaviqlock2b4VwAJnvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=redhat.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from SL2P216CA0082.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2::15) by
 SEYPR03MB6460.apcprd03.prod.outlook.com (2603:1096:101:51::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.8; Fri, 1 Apr 2022 19:24:38 +0000
Received: from PSAAPC01FT028.eop-APC01.prod.protection.outlook.com
 (2603:1096:101:2:cafe::6e) by SL2P216CA0082.outlook.office365.com
 (2603:1096:101:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29 via Frontend
 Transport; Fri, 1 Apr 2022 19:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 PSAAPC01FT028.mail.protection.outlook.com (10.13.38.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.19 via Frontend Transport; Fri, 1 Apr 2022 19:24:38 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Fri, 1 Apr
 2022 15:24:36 -0400
Received: from [10.46.54.234] (10.46.54.234) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Fri, 1 Apr
 2022 15:24:34 -0400
Message-ID: <d9aa08ef-cc0a-9edf-19a4-6fe75959b3b8@lenovo.com>
Date:   Fri, 1 Apr 2022 15:24:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [External] [discuss] Split /sys/firmware/acpi/platform_profile
 into ac and battery profiles?
Content-Language: en-US
From:   Mark Pearson <markpearson@lenovo.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Bastien Nocera" <hadess@hadess.net>
CC:     linux-acpi <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <03b7d1dc-42af-7964-ab7a-bdcc6644cc71@redhat.com>
 <4b3c2dce-6271-57c3-b9d0-a186b7c82b33@lenovo.com>
In-Reply-To: <4b3c2dce-6271-57c3-b9d0-a186b7c82b33@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.54.234]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4e09c22-6855-4be5-d176-08da14154372
X-MS-TrafficTypeDiagnostic: SEYPR03MB6460:EE_
X-Microsoft-Antispam-PRVS: <SEYPR03MB64609F529DFE85E949549E40C5E09@SEYPR03MB6460.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxWx1vtonnWiTaezyw8kNx9oklWf4yXVtYutzJsKTWZdnFPfvDFzhpyantD2B/AeTI6NBQ7BV8MmnGZtWa4ikZonNe1tL/dn6jZXDV7RoPIZ2YgzY+LasrVhlf3bupqXxdzS/e3e3gm1fGZWelsRvNeVdPD5PBm6Wzqs399/nS51Ykya70D3vF7rveyn4F7IrtaxosOCD8UGp6mQ4NHLCz9o10IF85mgEgzMt6bPR/cMbnVBqn9P++fRrxFkYXGxHiAJ7jHlFj6hW5IASz9ZTpqmXAH5L5YjoNkWP74yPfxvTtYCBj+mLUtUtC0ngshl/kqoKkCK5+9YKpUsebn7r7BNjCYm49uCjqlhtBg1cZALvD15dpmkDp8TCvWGeDqGSJq5E/kPlZYzApJgFgkAJzzQzgKvOFSpOWPi4S/8fgllJYHxAbrHxRRFOR/DyX28+GmhstQY5Dx+foL70unocw8dInWtm7NC2x6Ya/6n1b5Pwzqw7aw/WP1FKAGCzKR1M3hW1g0+YQI6MJ6ZJyy5IzyG1zF0FlCyIPJbbLz094XBS4jmQvIxKIIn7BfKdx/bS8UHzmebPQMmgN4Eb8IHcqQKK4JpwsRoSeq7bYsDUjjAhbb/brAV5FS7x00IaLa+iILh1TrvI5Z7sCS4oiSn/k2hkWQ2OuhjCoflBsS1GOBl45LFymZUwoIpXirpVVhZ1LFM77c96aI/YJrUvmDMMQXi/7OW5QnsPc90n7W5R7WYMdyAD9cAW00a/suOoa77XP7V6Yq7qxuAa9gmLd/4SxYA6Y+oQ2TIBPeH/atffSbXZFkTlLvz389JMuOs/QmHU1ZuTHF6C5sEfm1IpLkGt2wTY0gByYHOnmGyFByJtvtXc+DJfC6IIGjppuPBBrXTtc0h5i8MSzZ7hQKtI6pqcA==
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(82310400004)(966005)(356005)(6666004)(5660300002)(16576012)(36906005)(31696002)(70586007)(508600001)(70206006)(54906003)(110136005)(86362001)(4326008)(82960400001)(40460700003)(81166007)(8936002)(316002)(26005)(186003)(36860700001)(336012)(83380400001)(426003)(2906002)(2616005)(47076005)(16526019)(53546011)(31686004)(36756003)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 19:24:38.0282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e09c22-6855-4be5-d176-08da14154372
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT028.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6460
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi

On 3/21/22 18:29, Mark Pearson wrote:
> 
> Thanks Hans
> 
> On 2022-03-15 05:16, Hans de Goede wrote:
>> Hi All,
>>
>> AMD based ThinkPads (1) have separate ac (connected to an external 
>> powersource) and on battery tuned versions of the low-power, balanced
>> and performance profiles. So in essence they have six profiles:
>> low-power-ac, low-power-battery, balanced-ac, balanced-battery,
>> performance-ac and performance-battery.
>>
>> The question is how to deal with this. There is a previous
>> discussion about this here: 
>> https://lore.kernel.org/platform-driver-x86/20220301201554.4417-1-markpearson@lenovo.com/>>>  From that previous discussions 3 possible solutions come to mind:
>>
>> 1. Simply treat this as 6 different profiles, maybe with documenting 
>> -ac/-battery postfixes for the profile-names and let userspace sort
>> it out.
>>
>> Pro:    -Simple from the kernel side Contra: -Does not work with
>> existing userspace code -This is quite ugly IMHO / does not feel
>> right
> Agreed - I initially looked at implementing it this way and it's not
> good. I don't recommend it
> 
>>
>> 2. Only export three profiles to userspace, while going "all in" on
>> this concept and change drivers/acpi/platform_profile.c to add new: 
>> /sys/firmware/acpi/platform_profile_ac 
>> /sys/firmware/acpi/platform_profile_battery files which can contain
>> different desired settings for the ac/battery case and have the
>> kernel automatically switch between the two and also have it pass the
>> ac/battery state to platform_profile_handler.profile_set so that for
>> hw which has different ac/battery flavors of the profile the driver
>> knows which one to select (without needing to detect this itself)
>>
>> Pro:    -This matches well with the behavior which we want for the
>> user (which is for the system to save the profile as 2 separate
>> settings for ac/battery and switch the profile to the last selected
>> setting for ac/battery when the state changes) -Solve the ac/battery
>> state listening/notification only once instead of having all
>> platform_profile drivers DIY Contra: -This means deprecating
>> /sys/firmware/acpi/platform_profile and defining how it maps to the 2
>> new files, e.g. if it is written does that only set the current
>> active profile, or both ? -Userspace needs to be adjusted to use the
>> new uapi and once it has been adjusted it also still needs to work on
>> the older kernels which will be tricky/nasty to implement and also
>> is a problem from CI / testing pov.
> 
> I don't think the contra here is that complicated or causing backwards
> compatibility issues.
> 
> For the platform_profile attribute
>  - If you read it then you get the current active configured profile
> regardless of whether you are plugged in or not.
>  - If you set it then it sets both ac and battery profile and they
> stay in sync
> 
> For the platform_profile_ac and platform_profile_dc
>  - If you read it you get the configured setting for that power mode
>  - If you set it, then that mode is active for the appropriate power mode
> 
> I think that keeps this backwards compatible and user space can decide
> on their own schedule/preferences/design if they implement something extra.
> Am I missing something?
> 
>>
>> 3. Only export three profiles to userspace and have the 
>> drivers/acpi/platform_profile.c "core" code pass the ac/battery
>> state to platform_profile_handler.profile_set so that for hw which
>> has different ac/battery flavors of the profile the driver knows
>> which one to select (without needing to detect this itself)
>>
>> Pro:    -Solve the ac/battery state listening/notification only once 
>> instead of having all platform_profile drivers DIY -Leaves the
>> existing userspace API 100% unchanged and leaves existing userspace
>> code working without it requiring any changes Contra: -As part of the
>> discussion on this the RFE to "have separate "last selected"
>> ac/battery profile settings and automatically switch when the state
>> changes" has surfaced; and that is not solved
>>
> All looks reasonable to me.
> 
>>
>> Writing it down like this, to me 3. is the clear winner. The only 
>> downside of 3. I can come up with arguably is better solved in 
>> userspace (2), esp. since this will likely also require some UI
>> design work to somehow make it clear to the user that there are two
>> different settings (3).
> 
> For me I went with #2 in the RFC implementation as I thought it was a
> nice feature to have generally which is it's big plus - but I'm
> genuinely fairly split as to whether #2 or #3 is best. I could easily go
> either way.
> 
> One Q I have is that I would like our platforms to have the ability to
> auto-switch between AC and battery profile for their configured mode
> automatically. So if we go with option #3 I want to implement an event
> handler in the thinkpad_acpi driver for these platforms. Does that raise
> any flags or concerns? I prototyped this before I wrote the RFC and it's
> pretty simple.
> 
>>
>> Also even if no UI changes are deemed necessary this will still
>> require userspace changes to save+restore the two separate "last
>> selected" profile settings over reboots.
>>
>> Please let me know what you think of this, and of course another 
>> completely different approach is welcome too.
>>
>> Regards,
>>
>> Hans
>>
>>
>> 1) Although AMD based ThinkPads are the trigger for this discussion, 
>> this applies to more new AMD based laptops, so this is not ThinkPad 
>> specific
> It's not even really AMD specific - doing support for them was just want
> got the idea started.
>>
>> 2) IMHO it would be good to file a RFE issue for this against p-p-d: 
>> https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/issues/new>> Once we reach conclusion if this is a ack or nack I can do that.
> I'd love for my team to get more involved with development at that level
> if possible.
> 
>>  3) AFAICT Windows does the 2 separate "last selected" ac/battery
>> profile settings thing while just showing a single slider in its UI,
>> but that really is a whole other discussion which the userspace/UI
>> folks can have.
> 
> Thanks
> Mark

Just wanted to check that, with limited responses, this thread is
effectively closed and the decision is to go with #3 - we'll leave any
implementation up to user space (if they want to take it on). Maybe this
is the prod I needed to go and play there. As a note, if anybody does
take this and needs help testing etc just let me know.

I do plan to follow up with a thinkpad_acpi specific patch for our
platforms using PSC mode.

Mark

