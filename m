Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CAB59EB3F
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Aug 2022 20:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiHWSm3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Aug 2022 14:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiHWSmL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Aug 2022 14:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC3A8A6F7
        for <linux-acpi@vger.kernel.org>; Tue, 23 Aug 2022 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661274315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8p2uyAKXgw2ytHTuc+5AiV01x8sZyv3wGpjT1yNESQ=;
        b=Q/07UsNUHvW7QpnQXlnnT6Ztw3YlfwYpJnoRxbDwS8WmENvA2JY89xur65O4tIMHnaA1LR
        qEOFp2ghhcSicG5vmohuIMKWOrmQPaYd5tgSc3bpg6udRhyehSl3fGrk83eVOB2oGxupQE
        zGYbKkfYCf5OlD3bziHop3yAwHE4Ia4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-501-trV90d0QNrSkCcVVFUZBwQ-1; Tue, 23 Aug 2022 13:05:13 -0400
X-MC-Unique: trV90d0QNrSkCcVVFUZBwQ-1
Received: by mail-qk1-f198.google.com with SMTP id bs43-20020a05620a472b00b006bb56276c94so12632601qkb.10
        for <linux-acpi@vger.kernel.org>; Tue, 23 Aug 2022 10:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc;
        bh=B8p2uyAKXgw2ytHTuc+5AiV01x8sZyv3wGpjT1yNESQ=;
        b=UlQs1MLUiz0JjNe6IROld0n185ZeR3H0++NgS3LJM2iBJr1SHX0rj8sx90Z2VorgR0
         gDXQAWtAYCs1++CN/PCscIldTiYgEK/TdBqwQ3tB2x2tDtDu1fVMKdoiey8+TqtKHjds
         jOAQx3y1heSgCnyh+gxFXYujper1sw/qX5iBRNMmsQ3MGfAIIf5baN8zH34q3KQ5/PNY
         CMBElAS/T0RHOCReFMbPlL/SbzYwOGKxzyrQDaZpRN8aueW0+2yjDSH3jO5xiZbSxH+G
         aZzgkHIaY23T1B2AneAO3fYfwIsWbIBcMqCbfXIZLOE8vNqtmXFB2/v7ZPMd0aryqniw
         I5HA==
X-Gm-Message-State: ACgBeo1h5mVaBxikCrdec1nH4cowrazIICf6XxJzyfMG5dcmv2/j8+3D
        XvkJAQqDnv8WVXIF47pnvj0ecvY9C5LGg5oB61+VHbvs/qlRayCN1e/KB+THsn8H7iWywkEQzma
        Q8r0QCflwG6VVGWsyImSyMw==
X-Received: by 2002:a05:620a:258a:b0:6b6:641c:9e8b with SMTP id x10-20020a05620a258a00b006b6641c9e8bmr16600828qko.82.1661274312950;
        Tue, 23 Aug 2022 10:05:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5VzbZNjrVAgx+HYzqS7GNBWoc3UPU2Kb8TYsavXfFP9Ffx8P2stAafh7ymp52PM9Yl4vhjCw==
X-Received: by 2002:a05:620a:258a:b0:6b6:641c:9e8b with SMTP id x10-20020a05620a258a00b006b6641c9e8bmr16600803qko.82.1661274312625;
        Tue, 23 Aug 2022 10:05:12 -0700 (PDT)
Received: from [192.168.8.139] (pool-100-0-245-4.bstnma.fios.verizon.net. [100.0.245.4])
        by smtp.gmail.com with ESMTPSA id fb24-20020a05622a481800b003434d1a7a14sm11086541qtb.62.2022.08.23.10.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 10:05:11 -0700 (PDT)
Message-ID: <54f3e05187c4e923b3a746beff3be4071ed0f2e1.camel@redhat.com>
Subject: Re: [RFC 0/2] Stop the abuse of Linux-* _OSI strings
From:   Lyude Paul <lyude@redhat.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org, Len Brown <lenb@kernel.org>,
        nouveau@lists.freedesktop.org, hdegoede@redhat.com,
        ddadap@nvidia.com, Dell.Client.Kernel@dell.com,
        Aaron Ma <aaron.ma@canonical.com>
Date:   Tue, 23 Aug 2022 13:05:10 -0400
In-Reply-To: <CAAd53p6dTdWzkiyH6Sz=YubhdibvGa4hZ+EPN7mZA4aYSPd_6g@mail.gmail.com>
References: <20220819142519.5684-1-mario.limonciello@amd.com>
         <CACO55tuw_2QWFMr0t6-JfUiQ4M7V3ZMKC7jHYTyERypaU3TekQ@mail.gmail.com>
         <c10b243a7be185ba119bdfce9a46e609db3bdd3b.camel@redhat.com>
         <CAAd53p6dTdWzkiyH6Sz=YubhdibvGa4hZ+EPN7mZA4aYSPd_6g@mail.gmail.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 2022-08-23 at 11:47 +0800, Kai-Heng Feng wrote:
> [+Cc Aaron]
> 
> On Tue, Aug 23, 2022 at 5:18 AM Lyude Paul <lyude@redhat.com> wrote:
> > 
> > On Fri, 2022-08-19 at 17:44 +0200, Karol Herbst wrote:
> > > On Fri, Aug 19, 2022 at 4:25 PM Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:
> > > > 
> > > > 3 _OSI strings were introduced in recent years that were intended
> > > > to workaround very specific problems found on specific systems.
> > > > 
> > > > The idea was supposed to be that these quirks were only used on
> > > > those systems, but this proved to be a bad assumption.  I've found
> > > > at least one system in the wild where the vendor using the _OSI
> > > > string doesn't match the _OSI string and the neither does the use.
> > > > 
> > > > So this brings a good time to review keeping those strings in the kernel.
> > > > There are 3 strings that were introduced:
> > > > 
> > > > Linux-Dell-Video
> > > > -> Intended for systems with NVIDIA cards that didn't support RTD3
> > > > Linux-Lenovo-NV-HDMI-Audio
> > > > -> Intended for powering on NVIDIA HDMI device
> > > > Linux-HPI-Hybrid-Graphics
> > > > -> Intended for changing dGPU output
> > > > 
> > > > AFAIK the first string is no longer relevant as nouveau now supports
> > > > RTD3.  If that's wrong, this can be changed for the series.
> > > > 
> > > 
> > > Nouveau always supported RTD3, because that's mainly a kernel feature.
> > > When those were introduced we simply had a bug only hit on a few
> > > systems. And instead of helping us to debug this, this workaround was
> > > added :( We were not even asked about this.
> > > 
> > > I am a bit curious about the other two though as I am not even sure
> > > they are needed at all as we put other work arounds in place. @Lyude
> > > Paul might know more about these.
> > 
> > Some of the _OSI strings are totally fine. From my recollection:
> > 
> > [    0.242993] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> > ^ this one is needed to do a couple of ACPI tricks at startup to get the PCIe
> > device for audio on nvidia's GPU to be detected properly
> 
> This should be fixed by commit b516ea586d71 ("PCI: Enable NVIDIA HDA
> controllers").
> Aaron worked on more Lenovo systems than me, so he may be more sure of it.
> 
> > 
> > [    0.242993] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> > 
> > I don't actually know how necessary this is, but I'm hesistant to call this
> > one bad as it may be related to the funny mux configurations that I'm learning
> > may exist on HP machines.
> 
> Should be fixed by commit 8e55f99c510f ("drm/i915: Invoke another _DSM
> to enable MUX on HP Workstation laptops").
> 
> And for "Linux-Dell-Video", it should be fixed by 5775b843a619 ("PCI:
> Restore config space on runtime resume despite being unbound").
> 
> So actually I am in favor of removing them all.

Woo! Thank you for the help with this :3. Since this all seems to be in order:

Reviewed-by: Lyude Paul <lyude@redhat.com>

> 
> Kai-Heng
> 
> > 
> > > 
> > 
> > --
> > Cheers,
> >  Lyude Paul (she/her)
> >  Software Engineer at Red Hat
> > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

