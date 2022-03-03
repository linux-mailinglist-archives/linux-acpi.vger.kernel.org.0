Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DCE4CC367
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Mar 2022 18:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiCCRJP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Mar 2022 12:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiCCRJO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2022 12:09:14 -0500
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2441480DF;
        Thu,  3 Mar 2022 09:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1646327306; i=@lenovo.com;
        bh=yBYfeaFpKcucpizFUhw+umPHHg4sbc2bRvws1fya/FI=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=rgziB7QzsHoZ5wgcTl4qiEhHSHwglwOsZJHMaBgnRHBCyrYFokAzPcOgMlwwMB/fN
         iuL6fqKXlRQvaQmIPZUfw26TNW5LSmu+/UdbjGOJ21QyQzlir6J9AbKujfDmf7kuj3
         20EE1w4BlopU+wGeuUa+tORm/Y4vrM7c5uelikRRqIr55v+5mt7Y0LQKG/wvn81J4C
         eJItIwdJvHK27z3cn7QC+N1SMfTprjd68XWL62r6a4r8/NIDE77Hecmq+KsdWsqXic
         ljiGRwEvReuqCirkQKvMVUnxpSKSi4GnJDKyEyv5qDCJyupAGzD6D21b+KXtBpmJq5
         +h4dTrTOxv7yg==
Received: from [100.114.100.29] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.us-west-2.aws.ess.symcld.net id D7/CD-21932-A06F0226; Thu, 03 Mar 2022 17:08:26 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRWlGSWpSXmKPExsWSoV9jpsv1TSH
  J4O0JRos3x6czWSzf189osXj9MkaL1XteMFvM/TKV2YHVo/XSXzaPTas62Tze77vK5vF5k1wA
  SxRrZl5SfkUCa8a1nS+YCi7pVSx5sJG5gfG0WhcjFwejwFJmiUmTJjFDOItYJb7eamWCcNqYJ
  LbNu8MC4ggJzGWSOD/vOCOEc4hJon/LOqAeTg4JgeOMEt2r3CESnYwSu7f+YINwJjJJLJ+1B6
  r/MaPEiTkTmCGch4wSXavusHcxcnDwCthKTD8vBzKKRUBFYtGdV2wgNq+AoMTJmU9YQGxRgXC
  J+88+g8WFBUIlru39AWYzC4hL3HoynwnEFhEwlJiz4DoLRLxEYsPm51BXtDBK9B3pYgRJsAlo
  S2zZ8osNZC+ngLXEpUW6EPWaEq3bf7ND2PISzVtng70mJKAs8av/PNSbChJLf12CshMkmqccZ
  YSwJSWu3bzADmHLShw9O4cFwvaVmD5lI5StK/Fp7RpGkLUSAjkSs5/4QoTlJE71nmOawKg7C8
  nHs5B8NgvJdbOQXLeAkWUVo01SUWZ6RkluYmaOrqGBga6hoQmQNtQ1MjTUS6zSTdQrLdYtTy0
  u0TXSSywv1kstLtYrrsxNzknRy0st2cQITFcpRamXdzDO6P+pd4hRkoNJSZT31SmFJCG+pPyU
  yozE4oz4otKc1OJDjDIcHEoSvD8+AuUEi1LTUyvSMnOAqRMmLcHBoyTCO+cVUJq3uCAxtzgzH
  SJ1ilGX48q2vXuZhVjy8vNSpcR514LMEAApyijNgxsBS+OXGGWlhHkZGRgYhHgKUotyM0tQ5V
  8xinMwKgnzun8FmsKTmVcCt+kV0BFMQEds9ZADOaIkESEl1cDUrJwt+SfmW20p91W2aOm9t79
  fn9r/qNx6h5Wne8bjZ6Ive+T2576MW+gn93yzQdPZkNV78hh1LeZ8m7dpk+GUebd3Ki5+L+Vu
  VHBVNyAucI900VO968+uh39e1zjJ88fC6n7pa80aMX75GwSTn5rsnFZozhFh+f+PrerT+fyFR
  6uCv3w0Pb+h8mGx7aVplS352RO+iizPNdY7vLh774WVUqWyjNzHEtNucBr4Lu2R8DxoKSW6nv
  dZVOV/Zv7WB19aP26S3rxFcYr9LH3uDQbfjQ+IWn84ZBBdFRHl8bKr4lX3Brd3bJp9YfuqDGZ
  PuMa3Rt9BbsIkrZVs2QpFik/eXtP7FXPaeOPcnwGvdL8qsRRnJBpqMRcVJwIAKHq1fl4EAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-6.tower-636.messagelabs.com!1646327304!15310!1
X-Originating-IP: [104.47.124.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8540 invoked from network); 3 Mar 2022 17:08:25 -0000
Received: from mail-hk2apc01lp2054.outbound.protection.outlook.com (HELO APC01-HK2-obe.outbound.protection.outlook.com) (104.47.124.54)
  by server-6.tower-636.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Mar 2022 17:08:25 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFWfQCWmWXvBuybAMLuI6CFZF7WQTJAJS4yE/3wwXqBLCFAeoYaEmC07UG1zlHeHXQK/PIPHfj1eCF6/OqIWUlDFE2At/ERZSWft2Kt/ti1vI8Zt+Qr76X27Vwnl1OIv+mMruTQyo9QmrhHWnxgNMNZ2D+70T5xojPL2z0GoRHeFREzr2zwkPj4jv8n95XmV+ihH6Wt7oHKnn/15sfADRRTLxdpd6914KIiKkNLqNySmvWU9Y5jSiWgwyUQSfb9NxGEVsC5HEZg9Umq7ud3wdYzJs+HaggF4tHU8XZjHp01oQDsJk4a76oOp/4EcA3gVTVgqNoLcIXWRgUrKeXGBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBYfeaFpKcucpizFUhw+umPHHg4sbc2bRvws1fya/FI=;
 b=Ut4eMhjqUeO2VYOBhG9WuOahTrTPzm8rQlBP3+dwltuyMikha3OoxQ86ABrBzmRvFSEpAtoUS/slpzffXsCIw7cKuAJPGEE6U0C4UvGOQTNx7SFLNmfj7+2jMKogEuXBwRS/7sqELN9/rkpj+jWk8525gKqKSdnXDWNL1bnHuStwMlH3WHmzVRLeH+xjDKUagpPdH6ZvLr9vqT1IGvEu7r5ws9k3XvNPMofQ61kTQxHkGGJLaRm5z4DyM0G1Z6MablHdtfH1FEQMCGZQHFRvNW+Xl1dwGpP/aDVivA9cYmYXrJ/n0CH04gZJmq+AGpMjSZTRoICbBgh08RzA/MGD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.6) smtp.rcpttodomain=amd.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from PU1PR06CA0016.apcprd06.prod.outlook.com (2603:1096:803:2a::28)
 by PUZPR03MB6045.apcprd03.prod.outlook.com (2603:1096:301:b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.3; Thu, 3 Mar
 2022 17:08:22 +0000
Received: from HK2APC01FT038.eop-APC01.prod.protection.outlook.com
 (2603:1096:803:2a:cafe::f6) by PU1PR06CA0016.outlook.office365.com
 (2603:1096:803:2a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 17:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.6) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.6 as permitted sender)
Received: from mail.lenovo.com (104.232.225.6) by
 HK2APC01FT038.mail.protection.outlook.com (10.152.248.243) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 17:08:21 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.21; Thu, 3 Mar
 2022 12:08:19 -0500
Received: from [10.38.59.144] (10.38.59.144) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.21; Thu, 3 Mar
 2022 12:08:18 -0500
Message-ID: <73656cdd-64d7-b9d0-aff7-61e5b98c2799@lenovo.com>
Date:   Thu, 3 Mar 2022 12:08:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [External] Re: [RFC] ACPI: platform-profile: support for AC vs DC
 modes
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
CC:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linux-acpi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
References: <markpearson@lenovo.com>
 <20220301201554.4417-1-markpearson@lenovo.com>
 <e6a3380d-dcc4-8e61-cba0-813d2404ee1e@amd.com>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <e6a3380d-dcc4-8e61-cba0-813d2404ee1e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.59.144]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05efca1f-a460-4fe7-67b5-08d9fd386bb1
X-MS-TrafficTypeDiagnostic: PUZPR03MB6045:EE_
X-Microsoft-Antispam-PRVS: <PUZPR03MB6045E51CC50BF88CBD9AA809C5049@PUZPR03MB6045.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J6UuEQbI9FVeEV9mtSb2NBJXmhxXCNX1bIv3anQpjrCEWYkxvs5AARsrHIo8YLVAntsOnclMqYtBoCc3Nn4905A6dqb9Yw1H2k8YXaYS4iajXaXZgcRmRrm3VJF028JUgJxoIckN2PfQj3WtGilcv3WJXJQ8ifbx/6Cd3px4NuplrZ2iwLvofrkYNiT11CyxVRB+c94G5Y+hCgOi5dFFTcYeyplMnnk9nL2+znnobp9Ql+pMEVu+6en7D+un63bceSc3KtFz0O6b4YqWzNmWFu4VW3cbZivEQ2m/0VkyNv7ZdxZvxNrAaIDfdY9+ubFTpiKoqmJPu3gjY/V+cCGg7gYTejzNclgduGG0HB0DTKBXyaPS2XTdb65Dr8Opn6+ivlQ2J6oqAaGeDXsEC/aGdK73h9ClgtD6PApH5IXc5dZ7eLQQvF0E6vLfp7lktrGd1E3J6wNUPGyE7YqtmrPgaiDaF01ZYrqymlB70IUK8qGia0olK6Z+u0fpeUaETtw0hxMiRUAtRZXSdaZfIygSZhGdZ5nrvOCd8vHtZBWKDwSUb8eR4rwiRLvE0DSFbi2yz/qZiKHK13SxMHCIwfYJ3fdkKkGzymo/9POUT8oJmTeNcpujfWnSlAN+LsH15yxEJB6xc9OxeCraKoVDvyGEF/8dMSwgGYTanqjqCQHAiM2Qxne9uvfOfZpZgP6gqiwCr0LN4LLjQMSPUMCykFrjJNOGeiYz8EZg+KyJ18lGu6b1X6gA5bWDQLp02zZ1eVn32vsj7d52pZX5f7wV4vYJrEUzJPctiwMv+1SeGAWbTgap2kEMeCo65FUsGCXNDrJJ
X-Forefront-Antispam-Report: CIP:104.232.225.6;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(8936002)(356005)(82310400004)(83380400001)(5660300002)(2906002)(82960400001)(16576012)(2616005)(36906005)(53546011)(316002)(31696002)(426003)(336012)(6916009)(40460700003)(186003)(26005)(54906003)(16526019)(86362001)(81166007)(4326008)(8676002)(31686004)(47076005)(36860700001)(36756003)(70206006)(70586007)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 17:08:21.1576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05efca1f-a460-4fe7-67b5-08d9fd386bb1
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.6];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT038.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6045
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Thanks Mario!

On 2022-03-02 21:53, Mario Limonciello wrote:
> On 3/1/22 14:15, Mark Pearson wrote:
>> Looking for feedback on this feature. Whether it is worth
>> pursuing and any concerns with the general implementation.
>>
>> I've recently been working on PSC platform profile mode support
>> for Lenovo AMD platforms (patch proposed upstream last week).
>> One of the interesting pieces with the Lenovo PSC implementation
>> is it supports different profiles for AC (plugged in) vs DC
>> (running from battery).
>>
>> I was thinking of adding this support in the thinkpad_acpi driver,
>> but it seems it would be nicer to make this generally available for
>> all platforms that offer profile support.
>>
>> This implementation allows the user to set one profile for when a
>> system is plugged in, and a different profile for when they are
>> unplugged. I imagine this would be used so that performance mode
>> is used when plugged in and low-power used when unplugged (as an
>> example). The user could configure it to match their preference.
>>
>> If the user doesn't configure a DC profile it behaves the same as
>> previously and any ACPI power events will be ignored. If the user
>> configures a DC profile then when a system is unplugged it will
>> automatically configure this setting.
>>
>> I've added platform_profile_ac and platform_profile_dc sysfs nodes.
>> The platform_profile and platform_profile_ac nodes will behave the
>> same when setting a profile to maintain backwards compatibility.
> 
> To make it more deterministic I would say configure it like this:
> 1) If you write a profile to `platform_profile` and the backend supports
> both DC and AC profiles make it the default profile for both.  This is
> more like "backwards compatibility" mode
> 2) If you write a profile to `platform_profile_dc` and the backend
> supports both then don't do anything in `platform_profile_ac` and vice
> versa.  Require a user to write both of them explicitly.
> 
> That means you have a new state of "unset" for the profiles, but if you
> don't include the state then I think it can lead to confusing behaviors
> if userspace writes one vs the other first.
> 
So I don't think any backend support is particularly needed. If a platform
supports platform profiles, then having an AC vs DC mode doesn't need
anything special - it's just switching modes.

On the Lenovo AMD platforms in the thinkpad_acpi driver this will
trigger some extra niceness to use a separate set of profiles, but even
for the platforms that don't have this it's still nice to auto-switch to
(for example) a low-power mode when you unplug - and that doesn't need
any extra support beyond just supporting platform profiles

I like the suggestion on updating both if platform_profile is update but
I'm worried that it changes the current behaviour:

- on the Lenovo AMD profiles, the battery profile set are all lower
power/performance than the plugged-in profiles (by design)
- with the implicit setting of the dc mode we'd be changing the behavior
so that when you unplug performance will drop.

This is (usually) a good thing, and is I think what Windows users get,
but it's not what currently happens on Linux. To get back to full power mode
you'd have to disable the DC setting - which isn't particularly
intuitive. It's why in this initial implementation I made the dc setting
'opt-in'....but maybe I'm being over cautious.

Once user space has two sliders the whole point is moot - I suspect I'm
overthinking this :)

Ack on the unset state - I'll add that.

>>
>> If you read the platform_profile it will return the currently
>> active profile.
>> If you read the platform_profile_ac or platform_profile_dc node it
>> will return the configured profile. This is something missing from
>> the current implementation that I think is a nice bonus.
> 
> Yeah nice bonus.  Some inline comments on this.
> 
>>
>> User space implementation could potentially be used to do the same
>> idea, but having this available allows users to configure from
>> cmdline or use scripts seemed valuable.
>>
>> Note - I'm aware that I still need to:
>>   1) Update the API documentation file
>>   2) Implement a disable/unconfigure on the profile_dc setting
>> But I figured this was far enough along that it would be good to get
>> comments.
> 
> If backend doesn't support AC/DC I think you should return an error for
> one of them rather than trying to hide the difference.  Think about
> userspace - it might want to have say two sliders and hide one if one of
> them isn't supported.

See above - I don't think there are cases where this wouldn't be
supported. Let me know if I'm missing something

> 
>>
>> Thanks in advance for any feedback.
>>
>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
>> ---
>>   drivers/acpi/platform_profile.c  | 130 +++++++++++++++++++++++++++++--
>>   include/linux/platform_profile.h |   1 +
>>   2 files changed, 125 insertions(+), 6 deletions(-)
>>
<snip<
>> @@ -117,10 +227,14 @@ static ssize_t platform_profile_store(struct
>> device *dev,
>>     static DEVICE_ATTR_RO(platform_profile_choices);
>>   static DEVICE_ATTR_RW(platform_profile);
>> +static DEVICE_ATTR_RW(platform_profile_ac);
>> +static DEVICE_ATTR_RW(platform_profile_dc);
> 
> My opinion here is that if you are keeping the existing one in place to
> show "current" active profile and make the new ones to show you
> "selected" profile they should have a different naming convention.
> 
> Some ideas:
> - selected_*_profile
> - platform_profile_policy_*
> - *_policy
> 
> Something else that comes to mind is you can rename "platform_profile"
> as "active_profile" (but create a compatibility symlink back to
> platform_profile), but I don't know that's really needed as long as it's
> all well documented.
> 

I like the selected_*_profile - I'll go with that.
I'm less enthusiastic about symlinks - just feels messy.

Thanks for the feedback - very much appreciated
Mark
