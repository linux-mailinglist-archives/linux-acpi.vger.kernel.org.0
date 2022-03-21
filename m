Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1E64E32FC
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Mar 2022 23:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiCUWt2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Mar 2022 18:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiCUWtY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Mar 2022 18:49:24 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6797F440E10;
        Mon, 21 Mar 2022 15:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1647901772; i=@lenovo.com;
        bh=XlNvU4PdBppxBDJB+ROfKxCLPaszgvr/6pc5Du2m918=;
        h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=mztL1bOlxXPJnkIb8WlNg7WbueYYkfYtSkqYhQWEtxNHQlQ4XCF5VjjPBO5EghBp1
         mHDjmHNaXecAAL2UGuGdef1Ah4WLo6BQhYBK2oVlHcGBWPZ6ogr67/j08vHMhkoNCX
         suH5BP7PDAGz3OU3d4Es4VWmd1VzxqQ+RkBxjyO4M96kN8pv0QordY5cnIZW/hclP3
         frhkH1oeJZSa+6SXkA9sqatDoPPuTsNs8Lzwl8wUZDYU5G7EVFfV60T9tKv9gNGF2H
         aGwm4RuT8EFXAm/Kx1tyunV28wO48v2iKKVJnt9B/P3+HUW13GcvTiDhm0cBnEx5ti
         k+Tc78NhvWi5Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRWlGSWpSXmKPExsWSoS+Voev9xyL
  JYMVkc4uv326zW7w5Pp3JYvm+fkaL1XteMFucOX2J1eL67PNMDmwerZf+snn82raGxeP9vqts
  HluutrN4fN4kF8AaxZqZl5RfkcCacffYdaaC83oVjztXsTYwLlXrYuTiYBRYyiyx4dxMdghnE
  avE1WebWCCcTiaJyfPugWWEBOYwSWw6fAbKOcAk8XnfP0YQR0LgOKNE96F1TBCZTkaJH69OsU
  A4E5kkOq7cBMpwAjlPGCVenE6ASDxilJjc8JAZJMErYCtxu/sSmM0ioCqx4OQCFoi4oMTJmU/
  AbFGBcInu/ftZQWw2AW2JLVt+sYHYwgJZEm2P7oLZIgIrGSVuXK0GsZkFKiUm7+tkgVhsK3Hn
  5S42iLi4xK0n88EO4hSwk1jQNo0RIq4p0br9NzuELS+x/e0cZoheZYlf/eeBbA6gPxUkVn+VB
  wlLCCRINE85yghhS0pcu3mBHcKWlTh6dg4LhO0r0XqxhRnC1pWY+HUDE4SdI7H61kwoW07iVO
  85pgmMurOQfDwLyaWzkFw3C8l1CxhZVjFaJRVlpmeU5CZm5ugaGhjoGhqa6JqZAym9xCrdRL3
  SYt3UxOISXSO9xPJivdTiYr3iytzknBS9vNSSTYzABJZS5My9g/HXyp96hxglOZiURHlfPLRI
  EuJLyk+pzEgszogvKs1JLT7EKMPBoSTBu+sXUE6wKDU9tSItMweYTGHSEhw8SiK8/B+A0rzFB
  Ym5xZnpEKlTjMYcV7bt3cvMcenQlb3MQix5+XmpUuK8u0EmCYCUZpTmwQ2CJflLjLJSwryMDA
  wMQjwFqUW5mSWo8q8YxTkYlYR51UGm8GTmlcDtewV0ChPQKfqsZiCnlCQipKQamKRXxbOe7n3
  3cN4LlRXMUo+3PzHI0xHu/998/ZeqQsJax6umH1seaC3Zy6d8ji9hU97i7i3hv2r+rffXDtub
  bpMVfOe1ZYxEUM5CM7eK1h3XbGYXuZ/8L2LCOy+m1+yWQ4lO5YK2lxvP7zJs/ZZmbl64/rRIV
  3GNNM9K9x9szm+swyT2NEzneCERqGQpns9+J+2xyfI9flGP13NKN07/vvi3w7nEMJ9F7Uu/ra
  laEySy657pbzPLeI0Vfi7aGw6sCNEIVFh0+D2TYd29R7O4LS70a6ncfnTqUrto9tH3ektDX0l
  neU7fUnxflGfPppaOq2uvv8j9taK81Py5aVH/zZNhx2cn7mDbXlBgcvSrqBJLcUaioRZzUXEi
  AFtT8HZtBAAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-6.tower-635.messagelabs.com!1647901769!6427!1
X-Originating-IP: [104.47.26.104]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31553 invoked from network); 21 Mar 2022 22:29:31 -0000
Received: from mail-sgaapc01lp2104.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.26.104)
  by server-6.tower-635.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Mar 2022 22:29:31 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJrtlNM26+Ajl5sCeD2wVBS3vRziOPRm0UPF1PV9PGXdeNpGXSUnCC0gA/xoTFqIkOdgKrAL+izo0gpHSW9A97xsxNeMBrdX2SO65vkOE9UL7emQv8mucRoqbf7LdXAB+VNzdrB9p17DEbR7Zye5oX2EGD2377pA/OHyCFYZh20djDP2ZbuXOhrJ3Wrid+AMueXJtB4SEwhS3tRAeE5NTbf9zojPvaCJUaZTTM8rMMbWx84S2i2myKgXxLCF0uBk7LgaZ9UEX7y0D8M4I4WprN2DFFUNzvQx1tcvxKx6wO2tEmgPEgUNCPKdmRVP3P/rqR2dcQZgmO25utB8mKuZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlNvU4PdBppxBDJB+ROfKxCLPaszgvr/6pc5Du2m918=;
 b=jTZ2tC5um9hgkPFH08ZnYmmyBfQJql8mE+miyN2h9DovCRXKTGAo44Qrn94flrC7brM7Vlg6+Vwx9th6n5LuRXUCsvPIak6ExyEi1uohsugteIdMU5zqkS/nKLH7zbnTAgwEdaLy0JH7OGe39s2ZFFZDTwGOu9f28lBaipOdMkJG8pjtvim+12F6bTEj+Bj6SvNoib6zH6eFfva+fY6ijNUMmxa6eibdLn2Ek4nQDK4mueBd4t1C4DOUV6J4qCLrgRJCHPpbIiESLBVEgF2CJHHb13XlexSUj5SJtgiD91p88t1eRqatTBJB96dOVM26FZhM/RDA3pRIC3rMkRGK4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=redhat.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from SG2PR06CA0172.apcprd06.prod.outlook.com (2603:1096:1:1e::26) by
 HK0PR03MB4163.apcprd03.prod.outlook.com (2603:1096:203:95::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.16; Mon, 21 Mar 2022 22:29:28 +0000
Received: from SG2APC01FT0044.eop-APC01.prod.protection.outlook.com
 (2603:1096:1:1e:cafe::8b) by SG2PR06CA0172.outlook.office365.com
 (2603:1096:1:1e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22 via Frontend
 Transport; Mon, 21 Mar 2022 22:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 SG2APC01FT0044.mail.protection.outlook.com (10.13.36.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14 via Frontend Transport; Mon, 21 Mar 2022 22:29:27 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Mon, 21 Mar
 2022 18:29:25 -0400
Received: from [10.46.54.105] (10.46.54.105) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Mon, 21 Mar
 2022 18:29:23 -0400
Message-ID: <4b3c2dce-6271-57c3-b9d0-a186b7c82b33@lenovo.com>
Date:   Mon, 21 Mar 2022 18:29:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Mark Pearson <markpearson@lenovo.com>
Subject: Re: [External] [discuss] Split /sys/firmware/acpi/platform_profile
 into ac and battery profiles?
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Bastien Nocera" <hadess@hadess.net>
CC:     linux-acpi <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <03b7d1dc-42af-7964-ab7a-bdcc6644cc71@redhat.com>
Content-Language: en-US
In-Reply-To: <03b7d1dc-42af-7964-ab7a-bdcc6644cc71@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.54.105]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 709414e1-41bd-4ebd-503c-08da0b8a42e4
X-MS-TrafficTypeDiagnostic: HK0PR03MB4163:EE_
X-Microsoft-Antispam-PRVS: <HK0PR03MB4163C0390577C715BDEF9E24C5169@HK0PR03MB4163.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jyxDNe7gLHxXncUqhyZJM/83FKDv1ptkvCAopacbgjwQnn+2O/afaEBexR0jTCGCzK+5Iwo9F/Vvk1iPwfit0c1hwyesLmHG/pZtFj7EHT+5HukETdLNjw9W9ZkmkfLymNWY5T6poDXTtyr9R+7jNBifChDxIkvNhR8XifnIGpz7ctc6mdLZBVDNp2a605DTgpMNRKq9BD4jjhrPXoxuzOer8pMjEKLuEHgqL8e0oSrlWq6F51fjk5q4LtHps0cW8/6JcRy6l9cb5v3PgBBguHuQXry2MkBhNnnskI3N8WyQIt8q627+lXRXqvFOOC0jpykkICokLXJ+25cXl3/KVzmS5ltPNdQykofaek1ga17qVxh5Fz9pX03FKIrfG2qK3cemNFzv077OowB6FzO+t5SViBfvCBb3Or+nLyn75ABNp/m+5syz8eascG/KaPuCQGlM8MxjKEEtDxRYB/lBXQxavaWN0X6unCsEjgmqqu9z7iIf20NOdB58YhWaMt/cLennt75+bzjrvR5eiJn3FR2JIUvTQ6PyOalsxhUT557OcM7pD7h260aqT6wNnW4EQv+HzgrDK0AVmxwGQoaTtn2WE5p3Pulo6/C4R45gVfOBL89OOsMdxCgheBmFEiyz8JTwXZOu2iCDfumdIImRbi17lYjZFwC9KfK7UZPxskaYpulAh7OmXq6epIpz80ZADhTTmOLaaN51/seIlzrXQokuTB3mjwUVM2uDSyn8cxV8FDm38gWwikxUqwQNkiO1vcYkmLJw2sGg8J85UNhKOlj7W/NVWzA8YKi109fOd7CUGyaZSAsNp/jI/IJUNDOQp6XPCZz2wf2z3Z+G3snBA0k1tZ1SGC0U+NhKe7P2w5cPvQHa4MVVSVnAeX2EEZ9mUtyGtfBz9+b8gsNtE3Qwtw==
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8676002)(508600001)(356005)(40460700003)(966005)(36906005)(70586007)(70206006)(86362001)(4326008)(31696002)(82960400001)(5660300002)(110136005)(54906003)(53546011)(16576012)(316002)(81166007)(8936002)(2616005)(47076005)(82310400004)(2906002)(426003)(336012)(186003)(16526019)(83380400001)(26005)(36756003)(31686004)(36860700001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 22:29:27.6842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709414e1-41bd-4ebd-503c-08da0b8a42e4
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0044.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB4163
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Thanks Hans

On 2022-03-15 05:16, Hans de Goede wrote:
> Hi All,
> 
> AMD based ThinkPads (1) have separate ac (connected to an external 
> powersource) and on battery tuned versions of the low-power, balanced
> and performance profiles. So in essence they have six profiles:
> low-power-ac, low-power-battery, balanced-ac, balanced-battery,
> performance-ac and performance-battery.
> 
> The question is how to deal with this. There is a previous
> discussion about this here: 
> https://lore.kernel.org/platform-driver-x86/20220301201554.4417-1-markpearson@lenovo.com/>>
>  From that previous discussions 3 possible solutions come to mind:
> 
> 1. Simply treat this as 6 different profiles, maybe with documenting 
> -ac/-battery postfixes for the profile-names and let userspace sort
> it out.
> 
> Pro:    -Simple from the kernel side Contra: -Does not work with
> existing userspace code -This is quite ugly IMHO / does not feel
> right
Agreed - I initially looked at implementing it this way and it's not
good. I don't recommend it

> 
> 2. Only export three profiles to userspace, while going "all in" on
> this concept and change drivers/acpi/platform_profile.c to add new: 
> /sys/firmware/acpi/platform_profile_ac 
> /sys/firmware/acpi/platform_profile_battery files which can contain
> different desired settings for the ac/battery case and have the
> kernel automatically switch between the two and also have it pass the
> ac/battery state to platform_profile_handler.profile_set so that for
> hw which has different ac/battery flavors of the profile the driver
> knows which one to select (without needing to detect this itself)
> 
> Pro:    -This matches well with the behavior which we want for the
> user (which is for the system to save the profile as 2 separate
> settings for ac/battery and switch the profile to the last selected
> setting for ac/battery when the state changes) -Solve the ac/battery
> state listening/notification only once instead of having all
> platform_profile drivers DIY Contra: -This means deprecating
> /sys/firmware/acpi/platform_profile and defining how it maps to the 2
> new files, e.g. if it is written does that only set the current
> active profile, or both ? -Userspace needs to be adjusted to use the
> new uapi and once it has been adjusted it also still needs to work on
> the older kernels which will be tricky/nasty to implement and also
> is a problem from CI / testing pov.

I don't think the contra here is that complicated or causing backwards
compatibility issues.

For the platform_profile attribute
 - If you read it then you get the current active configured profile
regardless of whether you are plugged in or not.
 - If you set it then it sets both ac and battery profile and they
stay in sync

For the platform_profile_ac and platform_profile_dc
 - If you read it you get the configured setting for that power mode
 - If you set it, then that mode is active for the appropriate power mode

I think that keeps this backwards compatible and user space can decide
on their own schedule/preferences/design if they implement something extra.
Am I missing something?

> 
> 3. Only export three profiles to userspace and have the 
> drivers/acpi/platform_profile.c "core" code pass the ac/battery
> state to platform_profile_handler.profile_set so that for hw which
> has different ac/battery flavors of the profile the driver knows
> which one to select (without needing to detect this itself)
> 
> Pro:    -Solve the ac/battery state listening/notification only once 
> instead of having all platform_profile drivers DIY -Leaves the
> existing userspace API 100% unchanged and leaves existing userspace
> code working without it requiring any changes Contra: -As part of the
> discussion on this the RFE to "have separate "last selected"
> ac/battery profile settings and automatically switch when the state
> changes" has surfaced; and that is not solved
> 
All looks reasonable to me.

> 
> Writing it down like this, to me 3. is the clear winner. The only 
> downside of 3. I can come up with arguably is better solved in 
> userspace (2), esp. since this will likely also require some UI
> design work to somehow make it clear to the user that there are two
> different settings (3).

For me I went with #2 in the RFC implementation as I thought it was a
nice feature to have generally which is it's big plus - but I'm
genuinely fairly split as to whether #2 or #3 is best. I could easily go
either way.

One Q I have is that I would like our platforms to have the ability to
auto-switch between AC and battery profile for their configured mode
automatically. So if we go with option #3 I want to implement an event
handler in the thinkpad_acpi driver for these platforms. Does that raise
any flags or concerns? I prototyped this before I wrote the RFC and it's
pretty simple.

> 
> Also even if no UI changes are deemed necessary this will still
> require userspace changes to save+restore the two separate "last
> selected" profile settings over reboots.
> 
> Please let me know what you think of this, and of course another 
> completely different approach is welcome too.
> 
> Regards,
> 
> Hans
> 
> 
> 1) Although AMD based ThinkPads are the trigger for this discussion, 
> this applies to more new AMD based laptops, so this is not ThinkPad 
> specific
It's not even really AMD specific - doing support for them was just want
got the idea started.
> 
> 2) IMHO it would be good to file a RFE issue for this against p-p-d: 
> https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/issues/new>>
Once we reach conclusion if this is a ack or nack I can do that.
I'd love for my team to get more involved with development at that level
if possible.

>  3) AFAICT Windows does the 2 separate "last selected" ac/battery
> profile settings thing while just showing a single slider in its UI,
> but that really is a whole other discussion which the userspace/UI
> folks can have.

Thanks
Mark
