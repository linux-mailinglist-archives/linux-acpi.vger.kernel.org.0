Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816CF76B54E
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Aug 2023 14:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjHAM6x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Aug 2023 08:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHAM6w (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2023 08:58:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676EDD3
        for <linux-acpi@vger.kernel.org>; Tue,  1 Aug 2023 05:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690894684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ltNwPmf0DBc3jaGW3ILIUgoOOUs5zHEnfulHMvP47V8=;
        b=iOOrbKwnrVoYY6H08vrUe6rv5F7pNNmvmjSqToRIcJILERPa9GiyMZ5yufIHvOgqBmgSfq
        mnBekBOyi615XBqCJzbC6f/ZrYB0br4eIZ+es1krvnC1cvsHPiADxoMWJO7MdYpxkk4/Lw
        fU4njGnB6y9ui60ty9D2EiFV2eQBsMQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-Alig858MMg-mgSCUaS0u-Q-1; Tue, 01 Aug 2023 08:58:03 -0400
X-MC-Unique: Alig858MMg-mgSCUaS0u-Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-317955f1b5fso2018522f8f.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Aug 2023 05:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690894682; x=1691499482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltNwPmf0DBc3jaGW3ILIUgoOOUs5zHEnfulHMvP47V8=;
        b=hi6clpTBjZiicP2lhmp2OhImCFCzgFwtYOtuigvJK6wU//nlG/zAly1n0EzVDVIqb6
         Hptv7leRGDwq2lf5ktWfG66Zkq/iALbma8FuCdr2tiFkI2pNN6HdEHEPsbDa8SouiAgB
         dGqSuxhfx9vg9VtHo85s+r49ocubZfJNUe7Uj4OAoFVuWJ/rvl2iV5qgZszs5qUklHpG
         sLgVDXk5u/kFHnLCruNBers+Myhf9wKQuysXz9ZpipgK8Q7YpCHNAab13+v3vUZDIa//
         f8lcy0v/T74Z1c62At8uNFE7iKNBT8l45U+3tni7IKU2cA/BMgyNRBhsVPXAa4rG84xS
         qisA==
X-Gm-Message-State: ABy/qLZACWlQw2yivEavQ/r57FV9txx7fIBsWZJhPizlhdQ66nwGeNKp
        ga2hPeOM9zxD2EBFLfMRVDlrTuN4SC7VcIdxS4El5kXESNu9M1055IcBCJHnV99tUGBtK8FNx0J
        HATeoGt4X8a5BYBnu7495dQ==
X-Received: by 2002:adf:f40d:0:b0:317:65de:4389 with SMTP id g13-20020adff40d000000b0031765de4389mr1924146wro.61.1690894682305;
        Tue, 01 Aug 2023 05:58:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHoo11zj1dYrqOlvbGISYlbwfB8BTe7jczhVvLvrEe3m6UwQTYtrvjkuRmcyyJhcOovqeOm5A==
X-Received: by 2002:adf:f40d:0:b0:317:65de:4389 with SMTP id g13-20020adff40d000000b0031765de4389mr1924128wro.61.1690894681912;
        Tue, 01 Aug 2023 05:58:01 -0700 (PDT)
Received: from redhat.com ([2.52.21.81])
        by smtp.gmail.com with ESMTPSA id h18-20020adff192000000b003113ed02080sm15883453wro.95.2023.08.01.05.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:58:01 -0700 (PDT)
Date:   Tue, 1 Aug 2023 08:57:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        terraluna977@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230801085131-mutt-send-email-mst@kernel.org>
References: <20230731144418.1d9c2baf@imammedo.users.ipa.redhat.com>
 <20230731214251.GA25106@bhelgaas>
 <20230731175316-mutt-send-email-mst@kernel.org>
 <20230801115751.1e3b5578@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801115751.1e3b5578@imammedo.users.ipa.redhat.com>
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

On Tue, Aug 01, 2023 at 11:57:51AM +0200, Igor Mammedov wrote:
> On Mon, 31 Jul 2023 17:54:21 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Jul 31, 2023 at 04:42:51PM -0500, Bjorn Helgaas wrote:
> > > I would expect hot-add to be handled via a Bus Check to the *parent*
> > > of a new device, so the device tree would only need to describe
> > > hardware that's present at boot.  That would mean pci_root.c would
> > > have some .notify() handler, but I don't see anything there.  
> > 
> > That has a big performance cost though - OSPM has no way to figure out
> > on which slot the new device is, so has to rescan the whole bus.
> > 
> 
> Spec says following about OSPM receiving DeviceCheck
> ACPI6.5r 5.6.6 Device Object Notifications) "
> If the device has appeared, OSPM will re-enumerate from the parent.
> If the device has disappeared, OSPM will invalidate the state of the device.
> OSPM may optimize out re-enumeration.
> ...
> If the device is a bridge, OSPM _may_ re-enumerate the bridge and the child bus.
> "
> The later statement is was added somewhere after 1.0b spec.
> 
> According to debug logs when I was testing that hotplug still works
> I saw 're-enumerate from the parent', behavior.
> So there is space
> to optimize if there would be demand for that.

Yes I was talking about unplug.

> And 6.5 spec
> has 'Device Light Check', though using that would require some
> ugly juggling with checking supported revisions & co which were
> never reliable in practice.
> I don't know what Windows does in that case.
> 
> However if one has deep hierarchy, a BusCheck shall cause
> expensive deep scan. While for DeviceCheck it's optional 'may',
> and even that may is vague enough that one can read it as
> if it's 'a new bridge' then scan behind it while one can ignore
> existing bridge if it isn't DeviceCheck target.

And it's very clear that it's more efficient for removal.

> Regardless of that we can't just switch to BusCheck exclusively
> without harming existing setups which can legitimately use both
> methods.

-- 
MST

