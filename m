Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F03646544
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 00:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLGXlj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Dec 2022 18:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLGXli (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2022 18:41:38 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA808AAD1
        for <linux-acpi@vger.kernel.org>; Wed,  7 Dec 2022 15:41:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWrKX/ML7jEveUv1hA3yrpoBt/H/DehpijLjZeDQwPeoWTTn8sdoDyL2jXEIndi7Ij39DjduZ1KA9hczwyDRT54/BCKkqTK1ZoUTE2VmfD2g0jnPfPkbzmCromjAeifBywcGVaHaCqJc+L1utcFNIbi9F4JRCDEVO85CVyvpW/HpiQ75rNbvJk4VMjMPHXhrF7ctJKP+afiOXnKUWbJemUbCQoctuW2XwhimCmODJ7CCf7uNJiRs+Ca4Yy8RcTMivYLi2VObNenkYnQRZO0v7ov8QCiEkwUlLhlwYYK4AfhSBVSTm8SAuJv0Y8Mvpozxk0nIjm60MDFljstNBp6aEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=echx3hX+WxsgNlOTUdFSsp/XURoULSClyHRwMxvHrSk=;
 b=CeWqTihubc6e9QdO8MfG8GuQuXOEt0IOhRkrVgHgdQYW3+VxiB3JPXtcDdDcta5usqOvuV4pgqoiQsQOn2UOTfiatzK1MS0Ahvmy4B4Rl4gB/yfxurdNnqhaSebKv89StEHm1XI1TTlHHfhDEri8Y/XZny/KxXVmLa5aga78yLYKyYQx4zDLpnbvySRzmCNpfRv5VbyNtY14d7XkI/yWtiN9UL7FVqnaS1ZLV3cZFAkX08kZQrk0iLgHb7l9IwpTwg/ugLQiBihsh9Um6C+HSLJ/xi+lra5WfTskEqlL9jOMvd4t9Bfqm32hfkb+jQTxXt/7GMo9rTUc8CqPMFfmZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=echx3hX+WxsgNlOTUdFSsp/XURoULSClyHRwMxvHrSk=;
 b=p6CrsiXTsHai0cGiCor9XnBT2J+lungftZncTCtoTyD2fx1IeN7Wi9pLkBt5y7Jz/C4acQz9x43GLgGTkP/0wVOZ9KZqEG0izwJU1KrMlphT/F9PghefPqP9Hs8M9c3awqxRHf3OBePuTnPAOBrcULf2PSPhv3Ld93IrP7PLkghi6ILqPXUCFnsjHu5FF84JnE47KhNfxxBWiOIkgGxO8INRYg5CuxLDUHHa+KThDasLTpaUhBA2w4j6UqnhWSGC2QVaAaheO+tZYXagoquzEwlV3TnkC40vIAozU/nXJY+4rp9LLXWRMU8xYqHE28EFinpLKGywxcHqL1NQUkYQZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2763.namprd12.prod.outlook.com (2603:10b6:5:48::16) by
 PH0PR12MB5436.namprd12.prod.outlook.com (2603:10b6:510:eb::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 23:41:34 +0000
Received: from DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::fe89:eaf7:714f:d8a4]) by DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::fe89:eaf7:714f:d8a4%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 23:41:34 +0000
Date:   Wed, 7 Dec 2022 17:41:31 -0600
From:   Daniel Dadap <ddadap@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/2] Avoid creating acpi_video0 on desktop APUs
Message-ID: <Y5Ekq2ICRNZRuP5k@lenny>
References: <20221207193134.763-1-mario.limonciello@amd.com>
 <58ca6ed3-527e-8eed-0c50-64689e464fb4@redhat.com>
 <0c0b2a2c-7e70-50b4-c8e1-ef5e97447217@amd.com>
 <0d958ffb-88a6-cef3-d885-b1e0fd00c3fb@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d958ffb-88a6-cef3-d885-b1e0fd00c3fb@redhat.com>
X-ClientProxiedBy: DS7PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:5:3af::27) To DM6PR12MB2763.namprd12.prod.outlook.com
 (2603:10b6:5:48::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2763:EE_|PH0PR12MB5436:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d6d805-a2ec-4f32-b551-08dad8ac9347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xfMolcQz3JNcfhvz8X2VaOVPwsH7x27NRv/+pV3oEWjQj6JgNEQq2arrs62nSYTjR673zJ7gapp4FulYTnKMMgD1XOZXv3oHdvE0r29qxCMzQ00crX6gQbkBvY6CRtpm//hrgLnX+q4PQ1gF8yjvS/7ygfqNRoKk+669PyAziIUqDzuP9K4TX9r/jkjECKcbY0XvesLQ0MqGUEDRruzCZ6nrTVZzbnRGKd7jnEPO+9z7x8K6rqBHQv/x30WF2NmtoI9nAqIM+0l2AiJOgvd2jvS6eKB0Hm23VidlNR0kQvIyv9prdMNM72eZ9kenyskjayd/vIWVe7rzjqsWiywX/LxnxnoBO8WBHuPGXr9+krfKbS24OXEduDBvl42r1TYEnT8y9VO9EKrhZknvj3/L1lqV5/y/p6rbBgtvNdk38J+vTEAVJyJgFdvmZq1Y9mQv8uNuEa2pv4p9ehCDwYDTeuu0mSxGFBO4WJIrD8BHRzTrgLjaBwnerbJgK+UWb6ly5jaxkFXIPnrYiDqfpkijg+BPJy70EU51xWORs8uQe5xz1WTh1/Jnav8OCjBjzV7y3eeJ6QiAZh802y6HlNLmJrv7wUXNo0eIXwRDHb+wI81zhljPyXIJg7gm97v6nlpwoog8VKKlV86bLTzMo1CKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199015)(86362001)(83380400001)(8936002)(2906002)(4326008)(478600001)(6512007)(186003)(5660300002)(33716001)(8676002)(6666004)(66556008)(53546011)(9686003)(26005)(6506007)(6916009)(38100700002)(41300700001)(66476007)(66946007)(966005)(6486002)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4qD2KEuzZDLxNbG2dm3pkIHsOQGl0/ln7FCIQS+/+6eqokRA2i0ON357up?=
 =?iso-8859-1?Q?Ux37fZYO41wyPqb1En1dOvWkHRjVbiJoN5dqHOJP7keTXOHSlUMJur+UwE?=
 =?iso-8859-1?Q?AISA8QtMFUeBs5HO/LwbhRRUZhOG4lVtTd0qzgeX4gXPfZX9VKrzUxLj2I?=
 =?iso-8859-1?Q?dA/l0Eh8WCfKtVP4ls1Ksk8AzA+e6DufmxLOHdDuhFGXtBSMNKjmq4WSUv?=
 =?iso-8859-1?Q?v3gm6BHvYvDgTwtWWM08LP4DBD+2pdTXJnPDa8EzrfwW2iA7ad97vvPNbX?=
 =?iso-8859-1?Q?6WUZARe32JffZwie93/o3sgTsR3GQqR6gMBdwCms7oEWX0gw8tkKLsYj3I?=
 =?iso-8859-1?Q?MPBYVBZ8nlz46ZqgGkzKHen6i1WAOCE0Dgi3yVXIcJm461R+0BXrU2PNxS?=
 =?iso-8859-1?Q?Ne66YFLcaC63QbD61Md6fT0aAAEeQ1YK/8Gq4gqBQFiozadTsBoFF1b7rt?=
 =?iso-8859-1?Q?fHE5cncDU0VfBd7B68kItbEOU8d5UECDoO3dm4ZuU1q6VN/qiQPWbL4cK+?=
 =?iso-8859-1?Q?SbiLjd/fcD002/Mu70MKexQzXbDDJTIVZZbGK0pVhomKj6xcobREHT0PIu?=
 =?iso-8859-1?Q?KHORnuHJAiYqWPzxl09aH46nU8ssZRItt6i5bxAxLbbPshEa2f6oAXkw38?=
 =?iso-8859-1?Q?aDFY36AilSRQevle80rhFbV1PrsEXs5Jstznv9pV1N4LBPF8j2zJwYQLqh?=
 =?iso-8859-1?Q?j9fQcPhoqkB91csjZt92Y9Jf3r4zQUG3RN7+Ds0xInXihqHJi6lPvR4Qw3?=
 =?iso-8859-1?Q?var0v0cn7fy731jx3+PymVRg0RCSa+6inU819L8sJVA81kRXQEyICQCvQH?=
 =?iso-8859-1?Q?38KdSEm6WsiIlssg8z7yilGbU5wW98c2U8HATz7qf3lDKQk8llo5gJOKiy?=
 =?iso-8859-1?Q?/VbWg5lw4iuHYXnNLmZe6ulUJxYPEgJL/kQO4Xjj4wo7Thg+CvhR/JJL+4?=
 =?iso-8859-1?Q?GG3QPzR/tyvxlxvXNBNzEcWfgYlMcfxwSsx3Bz4tEj2hku6vElS3FA0jAS?=
 =?iso-8859-1?Q?AufixpFL6efTppeigS4/3Tnx176nSbonJQBXqUNx3h/JbMU+HjeXiLaXHI?=
 =?iso-8859-1?Q?Hi4XiPhbxHarVVdVhw48SFlHIgshlQ+uC6ATf84uFBhc6vBrX0pvc5FoXP?=
 =?iso-8859-1?Q?NcOAmhPJ6v3ln1UwqToMLtLqdu19Fb5QeDlYWjgX6doHc8P+1gLjiiw+Op?=
 =?iso-8859-1?Q?7NRwh8hdxjrHEmdjrmfcKNfkc3fTUTpr/M49zCB/NFudONejwVMSBQyYgQ?=
 =?iso-8859-1?Q?+lCqZR9k6k++bn3xrGnMZHHPadbBNcrPdi9zar0z9+aNZD51+nGQ5qIbf1?=
 =?iso-8859-1?Q?qa6SOc26xGmXn8fgIH0zoTBw06UCgXoWSKYDrt9h7buIHhR2BSPrXwTfiQ?=
 =?iso-8859-1?Q?ZKTGwsRW3yH2Z/eTFiTDJqwfhcWWEP1/Pq10QcGpE+lkNnpQF9cnytE0ez?=
 =?iso-8859-1?Q?ooQAKtFcNdrVt+GrdmqGN8a42XbUUROCTJQCHlzyZWCrUQyqiRYaJUjUWU?=
 =?iso-8859-1?Q?PyolqQd7AlpTs09UNieoxvLPmklPdqNvzGOQRG4XoRaOTmcQral8wv+ZPw?=
 =?iso-8859-1?Q?uQ0Mn9NE5TI/k+rsfsGKAlHUVcfLtuoJGBZgzG71Ve7IxLW8vMgW07/aCJ?=
 =?iso-8859-1?Q?K0nuY/y2GJ7HDSMDMoeIWofC0Ci8Ur6P8P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d6d805-a2ec-4f32-b551-08dad8ac9347
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 23:41:34.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+nCpF7x5aekz6iQFjwuFBN/+Au/CWo1OmW9VnXUlO9ByRsRGQ7cqE7/tWWCCJxEuIBj30FaTngZrKJshzAfpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5436
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 07, 2022 at 10:32:05PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 12/7/22 22:21, Limonciello, Mario wrote:
> > On 12/7/2022 15:04, Hans de Goede wrote:
> >> Hi All,
> >>
> >> Mario, thank you for working on this.
> > 
> > Sure
> > 
> > <snip>
> >>
> >> Note that the problem of the creating a non functional acpi_video0
> >> device happened before the overhaul too.
> >>
> >> The difference is that now we have the in kernel GPU drivers
> >> all call acpi_video_register_backlight() when they detect an
> >> internal-panel for which they don't provide native-backlight
> >> control themselves (to avoid the acpi_video0 backlight registering
> >> before the native backlight gets a chance to register).
> >>
> >> The timeout is only there in case no drivers ever call
> >> acpi_video_register_backlight(). nomodeset is one case, but
> >> loosing backlight control in the nomodeset case would be fine
> >> IMHO. The bigger worry why we have the timeout is because of
> >> the nvidia binary driver, for devices which use that driver +
> >> rely on apci_video# for backlight control.
> >>
> >> Back to the issue at hand of the unwanted (non functional)
> >> apci_video# on various AMD APU using desktops.
> >>
> > 
> > Thanks for explaining.
> > 
> >> The native drivers now all calling acpi_video_register_backlight()
> >> gives us a chance to actually do something about it, so in that
> >> sense the 6.1 backlight refactor is relevant.
> >>
> >>> To avoid this situation from happening add support for video drivers
> >>> to notify the ACPI video detection code that no panel was detected.
> >>>
> >>> To reduce the risk of regressions on multi-GPU systems:
> >>> * only use this logic when the system is reported as a desktop enclosure.
> >>> * in the amdgpu code only report into this for APUs.
> >>
> >> I'm afraid that there still is a potential issue for dual
> >> GPU machines. The chassistype is not 100% reliable.
> > 
> > Have you ever seen an A+N machine with unreliable chassis type?
> 
> Not specifically. I just know from experience to not
> rely on chassis type.
> 
> E.g. I would not be surprised to have some of the desktop-replacement
> class laptops from e.g. clevo which sometimes even come with
> a desktop CPU for moar power, have their chassis type wrong.
> 
> Granted those are not using AMD APUs (yet), but that might change
> with the ryzen 7000 series where every CPU is an APU too...
> 
> > Given Windows HLK certification and knowing that these are to
> > be based off reference BIOS of laptops, I would be really surprised
> > if this was wrong on an A+N laptop.
> 
> I agree this is unlikely. But I have seen all sort of wrong
> chassis-type settings in devices which are not from the
> big OEMs.  And AFAIK these sometimes also play fasr and loose
> with the Windows certification.
> 
> >> Lets say we have a machine with the wrong chassis-type with
> >> an AMD APU + nvidia GPU which relies on acpi_video0 for
> >> backlight control.
> >>
> >> Then if the LCD is connected to the nvidia GPU only, the
> >> amdgpu code will call the new acpi_video_report_nolcd()
> >> function.
> > 
> > + Dan Dadap
> > 
> > Dan - the context is this series:
> > https://patchwork.freedesktop.org/series/111745/
> > 
> > Do you know if this is real or just conceptual?

I'm not aware of any specific examples of an A+N system with the
incorrect chassis type, but I agree that relying on it to be accurate
seems a bit fragile. Besides the "notebook that says it's a desktop"
possibility that Hans speculated on, I could imagine e.g. an All-in-One
form factor system, whose design is more similar to a notebook,
reporting its chassis type as desktop.
 
> >>
> >> And then even if the nvidia binary driver is patched
> >> by nvidia to call the new  acpi_video_register_backlight()
> >> when it does see a panel, then acpi_video_should_register_backlight()
> >> will still return false.
> >>
> >> Basically the problem is that we only want to not try
> >> and register the acpi_video0 backlight on dual GPU
> >> machines if the output detection on *both* GPUs has not
> >> found any builtin LCD panel.
> >>
> >> But this series disables acpi_video0 backlight registration
> >> as soon as *one* of the *two* GPUs has not found an internal
> >> LCD panel.

Yeah, it does seem a little backwards to have the drivers report that
they do not see any panels, when we don't know whether there might be a
panel on another GPU whose driver hasn't registered its native backlight
handler yet. I trust the DRM drivers reporting whether a panel is
internal more than I'd trust the DMI chassis type - "positive" reporting
when a GPU driver finds an internal panel seems like it would be more
reliable than "negative" reporting when a GPU driver does not find any
internal panels. IIUC, that's the intent with having the DRM-KMS drivers
explicitly call acpi_video_register_backlight() if needed, as described
below.

> >> As discussed above, after the backlight refactor,
> >> GPU(KMS) drivers are expected to call
> >> acpi_video_register_backlight() when necessary for any
> >> internal panels connected to the GPU they are driving.
> >>
> >> This mostly fixes the issue of having an acpi_video0 on
> >> desktop APUs, except that the timeout thingie which was
> >> added to avoid regressions still causes the acpi_video0
> >> backlight to get registered.
> >>
> >> Note that this timeout is already configurable through
> >> the register_backlight_delay module option; and setting
> >> that option to 0 disables the timeout based fallback
> >> completely.
> >>
> >> So another fix for this might be to just change the
> >> default value of register_backlight_delay to 0 for
> >> kernel 6.2 .  This is a change which I want to make
> >> eventually anyways; so we might just as well do this
> >> now to fix the spurious acpi_video0 on desktop APUs
> >> issue.   And if this does cause issues for nvidia
> >> binary driver users, they can easily work around this
> >> by setting the module option.
> >>
> >> Or alternatively we could go with this series,
> >> reworked so that calling acpi_video_report_nolcd()
> >> only cancels the timeout.  This way drivers for another
> >> GPU can still get the acpi_video0 if necessary by
> >> explicitly calling acpi_video_register_backlight().
> >>
> >> Personally I have a small preference for just changing
> >> the default of register_backlight_delay to 0, disabling
> >> the timeout based fallback starting with 6.2 .
> > 
> > How about we do both?  Then you can always restore register_backlight_delay without risk of introducing
> > regression of acpi_video0 coming back to desktop APU's.
> 
> Doing both sounds like a good idea, I like it.

I suppose if there is a reason this needs to be structured with the
"negative" reporting, even on systems with multiple GPUs, that at least
one of the GPU drivers that *does* have an internal panel can decide
whether to register a native handler, or explicitly register the ACPI
video backlight handler. And even on an A+N system with a mux (and
without a GPU-agnostic backlight interface like nvidia-wmi-ec-backlight),
I'd expect that the system would POST to the (AMD) iGPU, and the panel
should be connected to the iGPU when the DRM drivers load. I guess what
I'm saying is I don't really see any value in the dmi_is_desktop() check
since I'd expect amdgpu to be the driver which owns the panel at boot
time, and even if that ends up not being the case, the dGPU driver can
fix things up later.
 
> It would be great if you can rework the series to just cancel
> the timeout from acpi_video_report_nolcd() + add a patch
> to change the default register_backlight_delay to 0.
> 
> >> I did not do this for 6.1 because there were already
> >> many other backlight changes in 6.1, so I wanted to
> >> have the fallback behavior there as a safeguard
> >> against things not working as planned.
> >>
> > 
> > If you're open to my idea of both since I'm already
> > touching all this anyway I am fine to roll that change
> > into another patch for default of 0 too in a v2.
> 
> Adding the patch for default of 0 sounds great, thanks.
> 
> Regards,
> 
> Hans
> 
> 
> 
