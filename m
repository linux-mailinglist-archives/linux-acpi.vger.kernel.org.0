Return-Path: <linux-acpi+bounces-2323-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6065B80F058
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 16:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F4FB21025
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D9B7542E;
	Tue, 12 Dec 2023 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRbidOED"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CAB12C
	for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 07:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702394734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIpQw8k3Ji1hQ+Q/rMJi3mOp+fmPt/8e4XsCNKHyBDU=;
	b=RRbidOED6rBPqIM2qZul3GfF2YqKJ05T1/6+QHhtgcaNVi8iuFey8L9lwTHatZ7rCd16Wo
	tRuwe3sPxUUAxpRxx8d16Ez8+odhyMsUfngai5a8FC0nHLjLlkt6dIPX54MybtS32+9r4R
	BF5Yxo0l1DJvQRflBC+qzdmPvbn5BC0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-oe-VUOTzOneE35Hw4hZb-w-1; Tue, 12 Dec 2023 10:25:33 -0500
X-MC-Unique: oe-VUOTzOneE35Hw4hZb-w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a0c510419caso100672566b.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 07:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394732; x=1702999532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIpQw8k3Ji1hQ+Q/rMJi3mOp+fmPt/8e4XsCNKHyBDU=;
        b=B/le13N5ZYJTjpl9Ulp2imrGudCMInpvgxq1Zj4wh/zqaThLZ7v+DM/aWdTlnBBuip
         CKen7w2FGTqXHMEsQn3eeJkvJv0DIHJEBCVnTV58L73QJkY1q58YT5l9VicUva2UXg6k
         ZOC7BOsh1ldXCEptGTrRl9ZiVqWQkologNEph6ArHbz96aZSrQKtmho7N3DlwIvaUjgv
         G65mjb/P/vycm1Xnsja7wN6+5dMq2o2RDXOkeqnbTgOHUST4oyldPOuRMnVxYcOKqrum
         KddtE9oMhRC3XGiVjdc/lFGHd/K6oVJZClYjgWNl/4KT+xUyZlev8YHPIZjUs/vD3Whf
         PdgA==
X-Gm-Message-State: AOJu0YzDSMRblzVT/xsLfpB85CiEQlGUN64bbZo4AkTUK+nq06y9d5LA
	DG6XVq2p93BXYRMKjYD3z1tsVLS10zyu3ZWm8w+jfzOHQuRzzUfSNuYpOuBcoZu5iJsoqUia7d2
	+CAIu2M394C8uzeAZQf1BKQ==
X-Received: by 2002:a17:906:10c7:b0:a1c:e980:3c3 with SMTP id v7-20020a17090610c700b00a1ce98003c3mr2652503ejv.28.1702394732280;
        Tue, 12 Dec 2023 07:25:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGASJRN+3155/H3UvqxOv26N1RhSjlb8LnjPrXAVZ+i+Dsz6c4kdn853kkeIlOvLJ4UnqcHDA==
X-Received: by 2002:a17:906:10c7:b0:a1c:e980:3c3 with SMTP id v7-20020a17090610c700b00a1ce98003c3mr2652496ejv.28.1702394731966;
        Tue, 12 Dec 2023 07:25:31 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id vh9-20020a170907d38900b00a1d18c142eesm6445227ejc.59.2023.12.12.07.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:25:31 -0800 (PST)
Date: Tue, 12 Dec 2023 16:25:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org, Thomas Lamprecht
 <t.lamprecht@proxmox.com>, mst@redhat.com
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231212162529.09c27fdf@imammedo.users.ipa.redhat.com>
In-Reply-To: <62363899-d7aa-4f1c-abfa-1f87f0b6b43f@proxmox.com>
References: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
	<20231207232815.GA771837@bhelgaas>
	<20231208164723.12828a96@imammedo.users.ipa.redhat.com>
	<20231211084604.25e209af@imammedo.users.ipa.redhat.com>
	<c6233df5-01d8-498f-8235-ce4b102a2e91@proxmox.com>
	<20231212122608.1b4f75ce@imammedo.users.ipa.redhat.com>
	<62363899-d7aa-4f1c-abfa-1f87f0b6b43f@proxmox.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 13:50:20 +0100
Fiona Ebner <f.ebner@proxmox.com> wrote:

> Am 12.12.23 um 12:26 schrieb Igor Mammedov:
> > 
> > it's not necessary, but it would help to find out what's going wrong faster.
> > Otherwise we would need to fallback to debugging over email.
> > Are you willing to help with testing/providing debug logs to track down
> > the cause?.
> >   
> 
> I submitted the dmesg logs in bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=218255
> 
> > Though debug over email would be slow, so our best option is to revert
> > offending patches until the cause if found/fixed.
> >   
> >>>>> Do you have to revert both cc22522fd55e2 and 40613da52b13f to make it
> >>>>> work reliably?  If we have to revert something, reverting one would be
> >>>>> better than reverting both.      
> >>>>    
> >>
> >> Just reverting cc22522fd55e2 is not enough (and cc22522fd55e2 fixes
> >> 40613da52b13f so I can't revert just 40613da52b13f).  
> > 
> > With UEFI setup, it still works for me fine with current master.
> > 
> > Kernel 6.7.0-rc5-00014-g26aff849438c on an x86_64 (ttyS0)
> >   
> 
> I also built from current master (still 26aff849438c) to verify and it's
> still broken for me.
> 
> > 
> > it still doesn't work with Fedora's 6.7.0-0.rc2.20231125git0f5cc96c367f.26.fc40.x86_64 kernel.
> > However it's necessary to have -smp 4 for it to break,
> > with -smp 1 it works fine as well.
> >   
> 
> For me it's (always with build from current master):
> 
> -smp 1 -> it worked 5 times out of 5
> -smp 2 -> it worked 3 times out of 5
> -smp 4 -> it worked 0 times out of 5
> -smp 8 -> it worked 0 times out of 5


I managed to reproduce it with upstream using fedora 40 config as is
(without converting it to mod2yesconfig).
So give me a couple of days to debug it before reverting.

> 
> Best Regards,
> Fiona
> 


