Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25DB76B01A
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Aug 2023 11:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjHAJ7U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Aug 2023 05:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbjHAJ7P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2023 05:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA1F1AE
        for <linux-acpi@vger.kernel.org>; Tue,  1 Aug 2023 02:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690883875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEMsxra+LCWfLb2lt7tAakASo7B5mFasYRwIBBZPXNE=;
        b=AM5Tj4kYwy+jUjFz0axbGW1HtNPHBR3T47oOzp/Cwca6VnG5eMNhjteX5pizC6raEeu+sE
        Q6ThrUQgH5p4Oek8M3JDCnhELMKIjYV2cE33IbgDqTgS6adsFJss+SVySxD22YHJhFGMew
        bJ3Sm7RIJnPo3cOptvzIbODQnrHuUF4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-bS-tXH5dOtG7SW8tIYmArQ-1; Tue, 01 Aug 2023 05:57:54 -0400
X-MC-Unique: bS-tXH5dOtG7SW8tIYmArQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99beea69484so300737266b.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Aug 2023 02:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690883873; x=1691488673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEMsxra+LCWfLb2lt7tAakASo7B5mFasYRwIBBZPXNE=;
        b=VS3X7WVfILLXj53v9pIyAhcWdmKK3AoiPvK3FJ3xMNwmI+B+ivIF1SP6YeUhdG/NCS
         zyVfGQSRc7ltCUGj48rpn/SC4DAG0xpJUTwryWkgbGGbnGOv60Yiq0AA9pDLbifpUODN
         V9MeaPyAQhYHd3idAMCkLNgEx4p9MjW6a47adDmx4k6CXCZmrWXvA44zjfeH1GN/BlCS
         8nEBNbYwVL2jrt4J0zyVfpS56VF+Dbb4IKI314cpyI8XjTVF5jCAmNybqk9G/5RU2qTz
         7KKThnNtCJXe3sx5X0A1P5VrxMqa/Ha6h5+2WtfFlkK9w0y1JQLHP2rwcWmSBimHmWxm
         NR7g==
X-Gm-Message-State: ABy/qLbyVSMdOFRRll9gNsQIkFjGgtso09DB5hTt9SOY7HcgIDBuTEwq
        CwnfTJnRBGjzlOUnRAZ2qG51SDsCmdLJYJtrDRsSBiPL9IG5vLE9XyvaWxKzy+RyyfqgxSkFk1+
        GewjtEb7es6itNox7D4l0hA==
X-Received: by 2002:a17:907:a06a:b0:969:93f2:259a with SMTP id ia10-20020a170907a06a00b0096993f2259amr1931204ejc.73.1690883873174;
        Tue, 01 Aug 2023 02:57:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEeWMr2y1ItuCqNQsKgehteVQkvzSTIHhGHBr2quBKeMKAAgcjojbLx/6yKKtQv7ckc1LIDSg==
X-Received: by 2002:a17:907:a06a:b0:969:93f2:259a with SMTP id ia10-20020a170907a06a00b0096993f2259amr1931191ejc.73.1690883872780;
        Tue, 01 Aug 2023 02:57:52 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q24-20020a17090622d800b0098d2f703408sm7351848eja.118.2023.08.01.02.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:57:52 -0700 (PDT)
Date:   Tue, 1 Aug 2023 11:57:51 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        terraluna977@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230801115751.1e3b5578@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230731175316-mutt-send-email-mst@kernel.org>
References: <20230731144418.1d9c2baf@imammedo.users.ipa.redhat.com>
        <20230731214251.GA25106@bhelgaas>
        <20230731175316-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 31 Jul 2023 17:54:21 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jul 31, 2023 at 04:42:51PM -0500, Bjorn Helgaas wrote:
> > I would expect hot-add to be handled via a Bus Check to the *parent*
> > of a new device, so the device tree would only need to describe
> > hardware that's present at boot.  That would mean pci_root.c would
> > have some .notify() handler, but I don't see anything there.  
> 
> That has a big performance cost though - OSPM has no way to figure out
> on which slot the new device is, so has to rescan the whole bus.
> 

Spec says following about OSPM receiving DeviceCheck
ACPI6.5r 5.6.6 Device Object Notifications) "
If the device has appeared, OSPM will re-enumerate from the parent.
If the device has disappeared, OSPM will invalidate the state of the device.
OSPM may optimize out re-enumeration.
...
If the device is a bridge, OSPM _may_ re-enumerate the bridge and the child bus.
"
The later statement is was added somewhere after 1.0b spec.

According to debug logs when I was testing that hotplug still works
I saw 're-enumerate from the parent', behavior. So there is space
to optimize if there would be demand for that. And 6.5 spec
has 'Device Light Check', though using that would require some
ugly juggling with checking supported revisions & co which were
never reliable in practice.
I don't know what Windows does in that case.

However if one has deep hierarchy, a BusCheck shall cause
expensive deep scan. While for DeviceCheck it's optional 'may',
and even that may is vague enough that one can read it as
if it's 'a new bridge' then scan behind it while one can ignore
existing bridge if it isn't DeviceCheck target.

Regardless of that we can't just switch to BusCheck exclusively
without harming existing setups which can legitimately use both
methods.

