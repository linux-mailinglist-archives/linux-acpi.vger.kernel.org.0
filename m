Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335904D8794
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 16:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241727AbiCNPBT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241779AbiCNPBR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 11:01:17 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CB3419BD;
        Mon, 14 Mar 2022 08:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1647270005; i=@lenovo.com;
        bh=VhmEFuPc2kPi+DrJphghnHoJKKlWJj/D0UnzSO4oitI=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=JfTaimswe7+ya4D+rCch1I9sFmsbrpjSl/hj+4K0GH/YIlVJDRnA6Qw1TZMGqKce8
         DzRqf+0lB/r9eld3tie1L+Jil4Z66xVGNOWbh13ioSQsym/0J/8YqBliDznvFQ1R9U
         NRPVdqklky3tqun9erTv0wDEK3lTgwP9KOHk8Sa1UKMy3hAbpHRP7v6tKGDLXXt5MP
         QjxfjWPSmh/IUb0EdEUhmneKPDjXSCBESHtVTMnMKojh4kZCmHA+QYhQ8CwZBBjuEo
         7XxIT6buB9dFvFFhl+lGmWeitrv/MVHxaNAD6MrTw9w35YQfcoeIKsMB8OYQK6Ube3
         +RtH8iHoOXKLQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRWlGSWpSXmKPExsWSoV9joVsSoZ9
  ksP+ZlMWb49OZLJbv62e0WLx+GaPF6j0vmC3mfpnK7MDq0XrpL5vHplWdbB7v911l8/i8SS6A
  JYo1My8pvyKBNWPPqV7mgttGFX+mPGZqYOzR7GLk4mAUWMossfjXYzYIZxGrxO/r7xkhnE4mi
  cnz7rGDOEIC85gkHv9cwALhHGSSuH5vDViPhMBxRonuQ+uYIDKdjBI/Xp2CKpvAJPHqzXOoAU
  8YJe58XMsM53Q+7gFyODl4BWwlVu5czwRiswioSrx89YEdIi4ocXLmExYQW1QgXOL+s89sILa
  wQKjEtb0/wGxmAXGJW0/mg/WKCERJ/Jj7AGwbs8BWRondUyAuFBL4wyKx9ehisA42AW2JLVt+
  gdmcAnYSZyf0MkFM0pRo3f6bHcKWl9j+dg7YdUICyhK/+s+D2RICihIrXm9hg7ATJJqnHGWEs
  CUlrt28wA5hy0ocPTuHBcL2lVj0/giUrSsx810PVE2OxPkp76DmyEmc6j3HNIFRdxaSp2cheW
  4WkvNmITlvASPLKkbrpKLM9IyS3MTMHF1DAwNdQ0MTXTNLXSNjM73EKt1EvdJi3dTE4hJdI73
  E8mK91OJiveLK3OScFL281JJNjMC0lVLk+mYH4/MVP/UOMUpyMCmJ8lox6ScJ8SXlp1RmJBZn
  xBeV5qQWH2KU4eBQkuCVDQfKCRalpqdWpGXmAFMoTFqCg0dJhDcpCCjNW1yQmFucmQ6ROsWoy
  3Fl2969zEIsefl5qVLivEz+QEUCIEUZpXlwI2Dp/BKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDk
  YlYd4WkEt4MvNK4Da9AjqCCeiIedJ6IEeUJCKkpBqYJldcl5j/Z7rOA0ee+d/59cyznzW80In
  i2vbuf5RqnY6xwcYf+y+yTZixbbGz+oLHrxNFZi5h85/68XdJXc1FqaADv8L2bM1d7M5fE/R6
  dpVqOfNhJbMLT3XLdLoZ+47POWH3ucV1ocktz13GRfsKf62K/mb1eZnhJueyE8+eHp1/bb+Gx
  c/dCs89kyf3iOlWJKlY1PN0Nk3nkH8uUKHzT7br8ZSFa9vTtT1cby8rsfmRfmkCY8Zjj/MW80
  M2PlUIzNY34U1Ob1nn3eg+7czqrvnZHTLSQbveJiy7k5vJkRq05ZxEgb7l6s3sZzfYpgrv42L
  Uc2lz1uB6flT7xCIuhaIt605av3tT/tA/5PsVJZbijERDLeai4kQAozzwlmIEAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-28.tower-715.messagelabs.com!1647270002!16217!1
X-Originating-IP: [104.47.124.56]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18744 invoked from network); 14 Mar 2022 15:00:04 -0000
Received: from mail-hk2apc01lp2056.outbound.protection.outlook.com (HELO APC01-HK2-obe.outbound.protection.outlook.com) (104.47.124.56)
  by server-28.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Mar 2022 15:00:04 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH8lEZvVXztdQSriWmklm7KGdqq2ymHLNOQnu4GpUkXidKXbj8pNRPNt5XUuPHMIh1XYBwvhj5FQFccSufjgT+Eb/CjMlOyeEk9pVpWcCI8DyDgmGufESug6yrQYKAWwu2s4UpnbTPfeudebykW/3MdJ5JRDaqM7Hot9gInqZeCCY+PkGcp65agT/X09h7LBlzRFqq7aemeWhP+yjxMlSdlIvyZjQHu/IwPofJPbyFKAGQlKX0NezcnBEejuw81h4ffca2AIRZNNwKCqrNMPHNWT6bymPffFH5l8w9OCUyUFXKq7VnMFJCwDI71TvznSKDn2yTVDdBp+OzKawB/pSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhmEFuPc2kPi+DrJphghnHoJKKlWJj/D0UnzSO4oitI=;
 b=AXaiwWYHOMj6wSfTJoZARxzRJYcln8oxZn/t6zm8zRnNPxxA9BFr0NwiXGpWH/11jNz3qtHwgYIzz0I5guORwR4SmSOUQiVcVyMHRn9mHerCM0QkCQKdEZaOLve3PgO0Hwq6YYk6Aa4gNYsXWS2WafYeMdUOXRzK1LVKt+VawD4nPtsVVU0dFvXbjIR7o2FT8y5AMilduIdBrOz3H6ea2FX9nTxPYgqQts4XUlGZ8jKL60/aHdMHPKtrp/wEQ00NX1MwEDW8udFd/TdnFTXCnttuR3hsoZNvZXW1/uAccwArYQkG0noQvtCZgzl4aepipekWvUkuF+806hwNbHog9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=redhat.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from PSXP216CA0017.KORP216.PROD.OUTLOOK.COM (2603:1096:300:4::27) by
 TY0PR03MB6679.apcprd03.prod.outlook.com (2603:1096:400:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13; Mon, 14 Mar
 2022 14:59:07 +0000
Received: from PSAAPC01FT028.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:4:cafe::9f) by PSXP216CA0017.outlook.office365.com
 (2603:1096:300:4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Mon, 14 Mar 2022 14:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 PSAAPC01FT028.mail.protection.outlook.com (10.13.38.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 14:59:06 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.21; Mon, 14 Mar
 2022 10:59:04 -0400
Received: from [10.38.111.194] (10.38.111.194) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.21; Mon, 14 Mar
 2022 10:59:04 -0400
Message-ID: <7fac7bee-124a-90b0-6f47-e7b7e9948d6c@lenovo.com>
Date:   Mon, 14 Mar 2022 10:59:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [External] Re: [RFC] ACPI: platform-profile: support for AC vs DC
 modes
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <markpearson@lenovo.com>
 <20220301201554.4417-1-markpearson@lenovo.com>
 <65d8cf3b-0eea-0583-fa23-e2c71287fb85@redhat.com>
 <BL1PR12MB5157CDB77675859B7F279578E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
 <7b281a37-5163-6cd7-360e-1c63bde714a8@redhat.com>
 <BL1PR12MB5157125246817A70649C12F7E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
 <1cd4ae24-ae92-302e-ac87-76ef15472a9f@redhat.com>
 <2180533b-c921-5ae4-e6bc-569728a4f990@lenovo.com>
 <c18abb55-6874-6e1e-bdb0-9d96d52987cd@redhat.com>
 <BL1PR12MB5157C14DE5F521D4B5C08366E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <c16ea8ba-5944-0384-4bc3-d5438fe5e1f7@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <c16ea8ba-5944-0384-4bc3-d5438fe5e1f7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.111.194]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6d7ff9d-81ac-48ea-5f0e-08da05cb3008
X-MS-TrafficTypeDiagnostic: TY0PR03MB6679:EE_
X-Microsoft-Antispam-PRVS: <TY0PR03MB6679CCD714CFAAC180E1BFF4C50F9@TY0PR03MB6679.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PftsHEauFcuuAXcCAVzBra+x96oEXr8XXAZTWFJiSD5Yvm4FSIpG3ab07j9LWy+ecwDlrqEgpRuS3hw70pM7JhwKlE8ZlNCcDSKu9uVuu7XkiyxeFmU3ABtxBus/YQbifOHuDcL+ZpGoGAuQ1hyS5wBBgAWxphiIL6fY/9t2UlXqfcnNwMNZDxa7MV1UmXqmufYcy2HNsozODw3+bJdyWJ/2o9AAAaY/QNZxTSAp1CG5XxTPH5zYbqzh152/jQTcrq3z1N8eh+C4dVwzFcjUu7a6pWYAPYnMP3nh6eL67QCUTe9bnD4AyBDS2POCIUhjtXmvlXz7ED90GSFqe/sm2ELcbi6i5m37aMi3gp+ISePh4Ba2hkWvQPN1BXmo8AEyuxMSceIMPbR745VsiaWD3Wq5AxlyUuFUY9kYZ+mLc2RUT9eJl0t9BQKU6gY2n2XE/326cUdWMxAxqzs/0YJhP9fv9SPe4tyLnoavQ90hyNMl2S42clMDmJyqRN8X0U/13JEG7s0lvCb8iHV1sPkp5EVM0NLKy+I5JygNbNYfgfSUN3An2G0kx5oeeEPTP5wkkvWQZMNHBl/UxplaOOmz7TX2rrbZAgX4fBR2VcoMb9uQGnY7NWipbNamVqU5CBA3C9C4f1LUQToQ8WUOV9ZYiqtqfsPldOm5Z7jJC3JeLQnYzjcdWyzIeVDeRZkpwJdEqEFWzfW1eCztE66Xbm7S89On5vHd+coGEp8m2duulG/fuS3imAf10fNLVa83GVndQ33NYdlhELfOxzKKdBPU7A==
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(53546011)(86362001)(31696002)(508600001)(8676002)(70586007)(70206006)(82310400004)(16576012)(110136005)(36906005)(54906003)(316002)(82960400001)(4326008)(47076005)(356005)(81166007)(336012)(16526019)(186003)(26005)(40460700003)(426003)(2616005)(36860700001)(83380400001)(36756003)(5660300002)(31686004)(8936002)(2906002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 14:59:06.4326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d7ff9d-81ac-48ea-5f0e-08da05cb3008
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT028.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6679
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Hi Hans & Mario

Thanks for all the comments.

On 2022-03-14 10:43, Hans de Goede wrote:
> Hi Mario,
> 
> On 3/14/22 14:39, Limonciello, Mario wrote:
>> [Public]
>>
>>>>
>>>> I cycled through a few different implementations but came down on what I
>>>> proposed. I considered 6 values - but I don't think that makes sense and
>>>> makes it overall more complicated than it needs to be and less flexible.
>>>
>>> Ah, so to be clear, my 2 scenarios above were theoretical scenarios,
>>> because I'm wondering how the firmware API here actually looks like,
>>> something which so far is not really clear to me.
>>>
>>> When you say that you considered using 6 values, then I guess that
>>> the firmware API actually offers 6 values which we can write to a single slot:
>>> ac-low-power,dc-lowpower,ac-balanced,dc-balanced,ac-performance,dc-
>>> performance
>>>
>>> ?
>>>
>>> But that is not what the RFC patch that started this thread shows at all,
>>> the API to the driver is totally unchanged and does not get passed
>>> any info on ac/dc selection ?  So it seems to me that the ACPI API Linux
>>> uses for this writes only 1 of 3 values to a single slot and the EC automatically
>>> switches between say ac-balanced and dc-balanced internally.
>>>
>>> IOW there really being 2 differently tuned balance-profiles is not visible to
>>> the OS at all, this is handled internally inside the EC, correct ?
>>>
>>
>> No - on Lenovo's platform there are 6 different profiles that can be selected
>> from the kernel driver.  3 are intended for use on battery, 3 are intended for
>> use on AC.
> 
> Ah, I already got that feeling from the rest of the thread, so I reread
> Mark's RFC again before posting my reply today and the RFC looked like
> the same 3 profiles were being set and the only functionality added
> was auto profile switching when changing between AC/battery.
> 
> Thank you for clarifying this. Having 6 different stories
> indeed is a very different story.

Apologies if I wasn't clear. I was trying to come up with a design that
took advantage of the AMD platforms have 6 settings, but was extensible
generally to other situations.

I will redo the patches and add the thinkpad_acpi on top - that will
help it be clearer.
> 
>>> Otherwise I would expect the kernel internal driver API to also change and
>>> to also see a matching thinkpad_acpi patch in the RFC series?
>>
>> The idea I see from Mark's thread was to send out RFC change for the platform profile
>> and based on the direction try to implement the thinkpad-acpi change after that.
>>
>> Because of the confusion @Mark I think you should send out an RFC v2 with thinkpad acpi
>> modeled on top of this the way that you want.
> 
> I fully agree and since you introduce the concept of being on AC/battery to the
> drivers/acpi/platform_profile.c cpde, please change the 
> profile_set and profile_get function prototypes in struct platform_profile_handler
> to also take a "bool on_battery" extra argument and use that in the thinkpad
> driver to select either the ac or the battery tuned low/balanced/performance 
> profile.

OK - I was thinking that, but I also figured the thinkpad driver could
get the power status directly so it was largely redundant (and saves churn
on all the other platform profile drivers - there are quite a few now)

> 
> And please also include an update to Documentation/ABI/testing/sysfs-platform_profile
> in the next RFC.
Absolutely - that was intended. My aim with this RFC was to get feedback
on if it was acceptable or not, and if the design had to change. Really
appreciate all the good points.

> 
> Also notice how I've tried to consistently use AC/battery in my last reply,
> DC really is not a good term for "on battery". AC also is sort of dubious
> for "connected to an external power-supply" but its use for that is sorta
> common and it is nice and short.
> 
> Sorry if this seems like bikeshedding, but using DC for "on battery" just
> feels wrong to me.
Ack - and I'm good with the suggestion.

> 
> 
>>>> The biggest use case I can think of is that a user wants performance
>>>> when plugged in and power-save when unplugged; and they want that to
>>>> happen automatically.
>>>
>>> Right, so this what I have understood all along and I'm not disagreeing
>>> that this is a desirable feature, but it _does not belong in the kernel_!
>>>
>>> Also taking Mario's remark about the EC-firmware using differently
>>> tuned balanced profiles based on ac vs dc, here is how I envision this
>>> working:
>>>
>>> 1. Laptop is connected to charger
>>> 2. EC notices this and:
>>> 2.1 Internally switches from balanced-dc settings to balanced-ac settings
>>> 2.2 Sends out an event about the laptop now being on AC, which the kernel
>>>     picks up and then sends to userspace (this already happens)
>>> 3. Userspace, e.g. power-profiles-daemon, gets the event that the laptop is
>>>    now an AC and in its settings sees that the user wants to switch to
>>>    performance mode on AC and uses the platform_api in its current form to
>>>    ask for a switch to performance mode
>>> 4. The EC gets a command telling it to switch to performance mode and
>>>    switches to the ac-tuned version of performance mode since the laptop is
>>>    on ac.
>>>
>>
>> None of this happens internally on the EC.
> 
> Ack, I understand now thank you for clarifying this.
Sorry for not being clear here

> 
>> Also there is nothing in this design
>> that guarantees it needs to be EC driven profile changes.  It could be other
>> mailboxes, ASL code, SMM etc.
>>
>> The key point here is that thinkpad acpi has 3 AC and 3 DC profiles to choose from,
>> so some level from thinkpad acpi above needs to pick among them.
> 
> Ack.
> 
I think this is what makes having the design in the kernel more important.

I understand the keeping the kernel small, but the thinkpad_acpi driver
needs to guarantee it knows it will get the notification. Without that I
don't think I can implement the feature reliably

An alternative to the implementation is for me to do this in just the
thinkpad_acpi driver and just for PSC mode, and that's what I started
with when I looked at this (it's quite a nice simple implementation FWIW).
But I figured having something that was configurable has benefits, and
something that is applicable to all platforms is a nice feature as well.

If doing thinkpad_acpi only would be preferred and more acceptable let
me know - but I think it's more limiting overall
Thanks
Mark
