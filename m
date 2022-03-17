Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85504DCBD7
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 17:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiCQQ5E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 12:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbiCQQ5D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 12:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91EAF19E0BE
        for <linux-acpi@vger.kernel.org>; Thu, 17 Mar 2022 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647536145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJsa7wvKwd46/cVQtbi6SOYKqPTE93PM/OCUFtfITc4=;
        b=HZ3WRNzrLY4tgpb5H/KmX2JBGsb+mlBYziyE2V2YeTjW7sySezSN7ahy1qJniu21xyRagG
        lJGGWT+jhLvu1g+iy2lkKR/eqhL7TzCm+IzBnMSO0VmVgH009QC6fUKK6Wr6XNhk9vQqb8
        u6X4qpPNca57/d162mBYru15ivSCw6Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-NGhPF9POOZK9GtrKAR20yw-1; Thu, 17 Mar 2022 12:55:44 -0400
X-MC-Unique: NGhPF9POOZK9GtrKAR20yw-1
Received: by mail-ed1-f70.google.com with SMTP id i22-20020a508716000000b0041908045af3so56032edb.3
        for <linux-acpi@vger.kernel.org>; Thu, 17 Mar 2022 09:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TJsa7wvKwd46/cVQtbi6SOYKqPTE93PM/OCUFtfITc4=;
        b=QboPCn/l2oZc9yzuZ1LOfY1lmabzhWKfKc5nHL28H2eUcSPb9+A1abky1Otg4la/aY
         KEKChLIUotJPe2a3c1n1fhseCNz9yftC4/KG+4jz440PRZX3o4V3La0Pal3B33nRVVqe
         Tfbn1W1UJ9Mn/aHRYxYHBe9CCg0UQYlKf7g+bKqiHbvgymAroAYDFY7yDMQ9XDkwH6La
         J8VumMnd3Uyo3dbGLAH/U0LZF+XFYL7S3UL8MILDpMERnjLQJD4qIzr0alOQ97dXmLv9
         S2q54fVyDO92UJo9m3VR+Yb2ddSgusILGcYOhgo0NNx9twVhpqA6cCI5M4fbUwhxYUMX
         T/gw==
X-Gm-Message-State: AOAM531JbPiBeUVIpfbovKrMEkMa8FP0+Qbs7IWiVUP4LdNyRnSBzeFs
        /DYOlRTziP4huzby1e06/ArOYrXxZCueyQF12NVYHs+8FoI3ciChAEpGAe0NvqatZ9qPa2a1HLI
        CI9hTbA7SuEkdDQdQH/f5Ng==
X-Received: by 2002:a17:907:7ea6:b0:6db:ca53:9b0a with SMTP id qb38-20020a1709077ea600b006dbca539b0amr5132122ejc.763.1647536142937;
        Thu, 17 Mar 2022 09:55:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBEImm5BYXKSo5OkQxxyw652H58hocO6yKICi65qeBQqy7YWwwSDnJUiMxonGFflVcPxBmTw==
X-Received: by 2002:a17:907:7ea6:b0:6db:ca53:9b0a with SMTP id qb38-20020a1709077ea600b006dbca539b0amr5132106ejc.763.1647536142725;
        Thu, 17 Mar 2022 09:55:42 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm2610066ejp.223.2022.03.17.09.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 09:55:42 -0700 (PDT)
Message-ID: <a3fc1c3d-8650-2a96-4e9e-2680ec1c8540@redhat.com>
Date:   Thu, 17 Mar 2022 17:55:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 1/4] ACPI / x86: Add support for LPS0 callback handler
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>
References: <20220317141445.6498-1-mario.limonciello@amd.com>
 <CAJZ5v0hNKmXWJ5uNaAFWsDkBm7FpKexkx5sCFHvx=OBJdVt+aA@mail.gmail.com>
 <BL1PR12MB5157188AC154FEA11F775674E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BL1PR12MB5157188AC154FEA11F775674E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On 3/17/22 17:49, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
>> -----Original Message-----
>> From: Rafael J. Wysocki <rafael@kernel.org>
>> Sent: Thursday, March 17, 2022 11:46
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>; Mark Gross
>> <mgross@linux.intel.com>; Rafael J . Wysocki <rjw@rjwysocki.net>; open
>> list:X86 PLATFORM DRIVERS <platform-driver-x86@vger.kernel.org>; ACPI
>> Devel Maling List <linux-acpi@vger.kernel.org>; S-k, Shyam-sundar <Shyam-
>> sundar.S-k@amd.com>; Goswami, Sanket <Sanket.Goswami@amd.com>
>> Subject: Re: [PATCH v5 1/4] ACPI / x86: Add support for LPS0 callback handler
>>
>> On Thu, Mar 17, 2022 at 3:15 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> Currenty the latest thing run during a suspend to idle attempt is
>>> the LPS0 `prepare_late` callback and the earliest thing is the
>>> `resume_early` callback.
>>>
>>> There is a desire for the `amd-pmc` driver to suspend later in the
>>> suspend process (ideally the very last thing), so create a callback
>>> that it or any other driver can hook into to do this.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> This looks good to me, so:
>>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
> 
> Thanks!
> 
>> and I don't have any conflicting changes queued up for 5.17, so from
>> my POV it can go in via the x86 platform drivers tree along with the
>> other patches in the series.
> 
> Hans,
> 
> FYI the series is based off of platform-x86/for-next also with changes to amd-pmc
> Rafael doesn't have in his tree, so I also agree it's better to go through x86 platform
> drivers.

Ok, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

So I'll go and merge this into review-hans, do some compile
tests and then push this directly to for-next to give it some
minimum baking time there before the 5.18 merge-window opens.

Regards,

Hans



> 
>>
>>> ---
>>> changes from v4->v5:
>>> * fix a check for handler->prepare
>>>   Reported by Dan Carpenter <dan.carpenter@oracle.com>
>>> changes from v3->v4:
>>> * drop use of mutex, use lock_system_sleep instead
>>> * don't pass argument of context, driver will maintain this internally
>>> * don't allow failing prepare stage
>>> * don't allow unregistering if sleep_no_lps0 is set
>>> changes from v2->v3:
>>> * Check that callbacks exist before calling
>>> changes from v1->v2:
>>> * Change register/unregister arguments to be struct
>>>
>>>  drivers/acpi/x86/s2idle.c | 40
>> +++++++++++++++++++++++++++++++++++++++
>>>  include/linux/acpi.h      | 10 +++++++++-
>>>  2 files changed, 49 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>>> index abc06e7f89d8..031b20a547f9 100644
>>> --- a/drivers/acpi/x86/s2idle.c
>>> +++ b/drivers/acpi/x86/s2idle.c
>>> @@ -86,6 +86,8 @@ struct lpi_device_constraint_amd {
>>>         int min_dstate;
>>>  };
>>>
>>> +static LIST_HEAD(lps0_s2idle_devops_head);
>>> +
>>>  static struct lpi_constraints *lpi_constraints_table;
>>>  static int lpi_constraints_table_size;
>>>  static int rev_id;
>>> @@ -444,6 +446,8 @@ static struct acpi_scan_handler lps0_handler = {
>>>
>>>  int acpi_s2idle_prepare_late(void)
>>>  {
>>> +       struct acpi_s2idle_dev_ops *handler;
>>> +
>>>         if (!lps0_device_handle || sleep_no_lps0)
>>>                 return 0;
>>>
>>> @@ -474,14 +478,26 @@ int acpi_s2idle_prepare_late(void)
>>>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
>>>                                 lps0_dsm_func_mask_microsoft,
>> lps0_dsm_guid_microsoft);
>>>         }
>>> +
>>> +       list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
>>> +               if (handler->prepare)
>>> +                       handler->prepare();
>>> +       }
>>> +
>>>         return 0;
>>>  }
>>>
>>>  void acpi_s2idle_restore_early(void)
>>>  {
>>> +       struct acpi_s2idle_dev_ops *handler;
>>> +
>>>         if (!lps0_device_handle || sleep_no_lps0)
>>>                 return;
>>>
>>> +       list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node)
>>> +               if (handler->restore)
>>> +                       handler->restore();
>>> +
>>>         /* Modern standby exit */
>>>         if (lps0_dsm_func_mask_microsoft > 0)
>>>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
>>> @@ -524,4 +540,28 @@ void acpi_s2idle_setup(void)
>>>         s2idle_set_ops(&acpi_s2idle_ops_lps0);
>>>  }
>>>
>>> +int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
>>> +{
>>> +       if (!lps0_device_handle || sleep_no_lps0)
>>> +               return -ENODEV;
>>> +
>>> +       lock_system_sleep();
>>> +       list_add(&arg->list_node, &lps0_s2idle_devops_head);
>>> +       unlock_system_sleep();
>>> +
>>> +       return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(acpi_register_lps0_dev);
>>> +
>>> +void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
>>> +{
>>> +       if (!lps0_device_handle || sleep_no_lps0)
>>> +               return;
>>> +
>>> +       lock_system_sleep();
>>> +       list_del(&arg->list_node);
>>> +       unlock_system_sleep();
>>> +}
>>> +EXPORT_SYMBOL_GPL(acpi_unregister_lps0_dev);
>>> +
>>>  #endif /* CONFIG_SUSPEND */
>>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>>> index 6274758648e3..47c16cdc8e0e 100644
>>> --- a/include/linux/acpi.h
>>> +++ b/include/linux/acpi.h
>>> @@ -1023,7 +1023,15 @@ void acpi_os_set_prepare_extended_sleep(int
>> (*func)(u8 sleep_state,
>>>
>>>  acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>>>                                            u32 val_a, u32 val_b);
>>> -
>>> +#ifdef CONFIG_X86
>>> +struct acpi_s2idle_dev_ops {
>>> +       struct list_head list_node;
>>> +       void (*prepare)(void);
>>> +       void (*restore)(void);
>>> +};
>>> +int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>>> +void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>>> +#endif /* CONFIG_X86 */
>>>  #ifndef CONFIG_IA64
>>>  void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
>>>  #else
>>> --
>>> 2.34.1
>>>

