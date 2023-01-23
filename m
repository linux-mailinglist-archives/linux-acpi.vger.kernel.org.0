Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686CC677B28
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 13:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjAWMjc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 07:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjAWMjb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 07:39:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34938EC75
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 04:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674477521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=500lft1xlkAA4ADQWJUKJkyLFfmb0OAXtKVLwPd2khs=;
        b=hor0KG/WfuJ0WEiWtwR70KzU/J6xfJPkeJZQXZO6gBV6O60XfeBSFNNfRE3lgIQAhklTAP
        elCV8xGGn9CZI7TE2pUQCRTt/rvvOhXHTp5Nmo5e0uc9IabzZn/deZyHZgwkTqaWYG6wGS
        b6kMOy8EKCKMCgzVPJjrrXld1P1U8n0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-544-RQiRr6DsMNinE0DaTC14yQ-1; Mon, 23 Jan 2023 07:38:39 -0500
X-MC-Unique: RQiRr6DsMNinE0DaTC14yQ-1
Received: by mail-ej1-f71.google.com with SMTP id hp2-20020a1709073e0200b0084d47e3fe82so7578303ejc.8
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 04:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=500lft1xlkAA4ADQWJUKJkyLFfmb0OAXtKVLwPd2khs=;
        b=cViQcxDNdRyk9BDTGvpxmzxem6rNqYcr/vrD/YEsCaC7RsmYe4/lHaXUrNCWyTK81i
         2YM0L08Xx6FF/bFiBtuJ9CSV20wSbDFYNZ35d9vGdIgEnMeRjUixkXue21zbu6NrtHOe
         8ghdQIHF7Tgl6QdzMxR7FTxZPF4SpCCai5oV/BjgKcWKM7CiUWjnZ+WWYHLzWf9PpDLv
         Dan9VZFojTkB51PczMGGOXOOn87MlE99463B8WwewECRH5yQKzFFr9yz08nvBoq1E6KO
         Afy+g1Z76D/hEun/BkK8HVKq23DFY2mo5zpcVHwdCzPowH+eTzW8LSMvdU9N6c7saZ1w
         6eWw==
X-Gm-Message-State: AFqh2krC4Y+aO2qvMypgPas3jP6vBJn0SbiXF01mtILZcBShzOK91C5r
        mGJpiqvrund0sq71pM3WYrVUUQoXKP4v1+dcmw6uuNqfkD4p8Gqe+jxFLB9b3nq2RIKdQdw+NBe
        dSBuDkkZaZ5IsZJP4jDEpWQ==
X-Received: by 2002:a05:6402:3583:b0:49d:fd6d:925d with SMTP id y3-20020a056402358300b0049dfd6d925dmr33832286edc.23.1674477518754;
        Mon, 23 Jan 2023 04:38:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvuOWILWyIKpbGeiNOwF5AhkJTKcGJdZUmCOXgIzYZwrHUVKpSY4sy3Drynrny/vZdHXvm++Q==
X-Received: by 2002:a05:6402:3583:b0:49d:fd6d:925d with SMTP id y3-20020a056402358300b0049dfd6d925dmr33832267edc.23.1674477518562;
        Mon, 23 Jan 2023 04:38:38 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id t32-20020a056402242000b0049148f6461dsm21379946eda.65.2023.01.23.04.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 04:38:38 -0800 (PST)
Message-ID: <255bf66e-eb27-af2b-9a13-8b7d4b7b3c46@redhat.com>
Date:   Mon, 23 Jan 2023 13:38:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/3] ACPI: video/apple-gmux: Improve apple-gmux backlight
 detection
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-acpi@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20230123113750.462144-1-hdegoede@redhat.com>
 <20230123120900.GA1924@wunner.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230123120900.GA1924@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/23/23 13:09, Lukas Wunner wrote:
> On Mon, Jan 23, 2023 at 12:37:47PM +0100, Hans de Goede wrote:
>> Some apple laptop models have an ACPI device with a HID of APP000B
>> and that device has an IO resource (so it does not describe the new
>> unsupported MMIO based gmux type), but there actually is no gmux
>> in the laptop at all.
>>
>> This patch-series improves the drivers/acpi/video_detect.c so that
>> it no longer tries to use the non present gmux in this case.
>>
>> Note I'm still waiting for testing feedback from the reporter of
>> this problem. But from the logs the problem is clear
>> (the logs show: "apple_gmux: gmux device not present")
> 
> Please provide a link to the original report.  I would also like to
> know the exact MacBook model used and I would like to see full dmesg
> output as well as an acpidump.

I only have a report by private email. This does include full dmesg
output and an acpidump. I will forward this to you in a private
email.

The reporter describes their model as a macbookpro8,1.

> What you're saying here is that there's a fake APP000B device present
> in DSDT

Yes that is exactly what I'm saying.

> and I have a hard time believng that.

Yes that seems to be exactly what is happening. If you look at
the drivers/platform/x86/apple-gmux.c code that is pretty much
the only scenario which leads to the:

apple_gmux: gmux device not present

message getting logged; and it seems to me that the reason that
check is there likely is exactly because of such machines
actually existing.

And /sys/class/backlight contains only intel_backlight
suggesting that this is not a hybrid gfx machine. Which also
matches with the specs which I can find for the  macbookpro8,1.

Yet there is an APP000B device present in the DSDT, here is
the relevant bit of the DSDT:

                Device (GMUX)
                {
                    Name (_HID, EisaId ("APP000B"))  // _HID: Hardware ID
                    Name (_CID, "gmux")  // _CID: Compatible ID
                    Name (_STA, 0x0B)  // _STA: Status
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0700,             // Range Minimum
                            0x07FF,             // Range Maximum
                            0x01,               // Alignment
                            0xFF,               // Length
                            )
                    })
                    Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                    {
                        0x16, 
                        0x03
                    })
                    Scope (\_GPE)
                    {
                        Method (_L16, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
                        {
                            Notify (\_SB.PCI0.LPCB.GMUX, 0x80) // Status Change
                        }
                    }

                    Name (GMGP, 0x16)
                    Method (GMSP, 1, NotSerialized)
                    {
                        If ((Arg0 <= 0x01))
                        {
                            GP06 |= Arg0
                        }
                    }

                    Method (GMLV, 0, NotSerialized)
                    {
                        Return (GP06) /* \GP06 */
                    }
                }
            }

Regards,

Hans

