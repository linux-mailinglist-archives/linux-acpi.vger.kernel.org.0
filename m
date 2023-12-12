Return-Path: <linux-acpi+bounces-2335-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2353980F764
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 21:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7B81F2172D
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 20:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812D252775;
	Tue, 12 Dec 2023 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMZnxkZV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D37BD
	for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 12:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702411386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLTa2dYRrf09pJMNBsngii2VsJyLNKDZosllwS5YIfQ=;
	b=SMZnxkZVVZVQcXO0StnG4Hq4kNy+4c1Pu9jVFAFNd0mbshsya64DtsQs2KY7XWA6+lB/X0
	Edy8tmyXqirgnWUGHiF62ObKBWq20KVu4qiwi0Ke9HwFthPzaZVp5JqvJ+OQurczHtid4R
	30eX79qMvVnF8urx5+J21pFzqHYELuQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-LtklpIUTNyut3xiNzPV73A-1; Tue, 12 Dec 2023 15:03:02 -0500
X-MC-Unique: LtklpIUTNyut3xiNzPV73A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1cfd84b473so681186666b.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 12:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411380; x=1703016180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLTa2dYRrf09pJMNBsngii2VsJyLNKDZosllwS5YIfQ=;
        b=MoFqhCKMWzIgtWPhcHYznZuTpq21ZdDqQV1vJQ90Nwl6dHaZq5pyiiA3FxcaBCCcW+
         +mlwxYqgFyKOeK+U2DphDLkxgkvFbtfcPWpMiqwjclHYTYjb79BFfyvx+SMUu1GIhYNU
         5kmS/bCvk5MAck92ARGY375AlG5m3OznmBVpSXSYT/EjZmuMSYZFj13mO/TplTNyXo5/
         ARQmh6WJLjvDpdI2LP9AZSdW0YaRpzs3GHdlq6DDaj8mbXisCrcxeTgYSe3AwrKnEBYo
         94t1sZTNBUOCsINhUwW+TdDF4TK/+/hiETSPkQtoceUUiz1+cA1+eK6Mp8OceTs1kA2q
         didQ==
X-Gm-Message-State: AOJu0YxVcLK0iHFGNJi1Qg5uGRJ3WsWW3Rdaj7iHBjnLs3C5lZonuDz5
	eFTW7t2XNybd5dzfAFMql5j5OwZJHnbvQo6PzGMJl1VHCPP+oEO6/zaWMP7TVJNlzzmyJO9cwQw
	ZBgLzIDJbZ5Qjk0OoYX4E1mGpFBpg1g==
X-Received: by 2002:a17:906:9588:b0:a1c:c2f9:980d with SMTP id r8-20020a170906958800b00a1cc2f9980dmr6331020ejx.27.1702411380001;
        Tue, 12 Dec 2023 12:03:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRYpIZTRZBTE4WcrlyktfS653hxvSiRGlBv7+Y1axU2HeESlSi0L3nguCi3mJ4p5t6evrUkA==
X-Received: by 2002:a17:906:9588:b0:a1c:c2f9:980d with SMTP id r8-20020a170906958800b00a1cc2f9980dmr6331007ejx.27.1702411379730;
        Tue, 12 Dec 2023 12:02:59 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
        by smtp.gmail.com with ESMTPSA id tl18-20020a170907c31200b00a1da2c9b06asm6698148ejc.42.2023.12.12.12.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:02:58 -0800 (PST)
Date: Tue, 12 Dec 2023 21:02:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org, Thomas Lamprecht
 <t.lamprecht@proxmox.com>, mst@redhat.com, Dongli Zhang
 <dongli.zhang@oracle.com>
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231212210257.5ddbff0d@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231212162529.09c27fdf@imammedo.users.ipa.redhat.com>
References: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
	<20231207232815.GA771837@bhelgaas>
	<20231208164723.12828a96@imammedo.users.ipa.redhat.com>
	<20231211084604.25e209af@imammedo.users.ipa.redhat.com>
	<c6233df5-01d8-498f-8235-ce4b102a2e91@proxmox.com>
	<20231212122608.1b4f75ce@imammedo.users.ipa.redhat.com>
	<62363899-d7aa-4f1c-abfa-1f87f0b6b43f@proxmox.com>
	<20231212162529.09c27fdf@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 16:25:29 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 12 Dec 2023 13:50:20 +0100
> Fiona Ebner <f.ebner@proxmox.com> wrote:
> 
> > Am 12.12.23 um 12:26 schrieb Igor Mammedov:  
> > > 
> > > it's not necessary, but it would help to find out what's going wrong faster.
> > > Otherwise we would need to fallback to debugging over email.
> > > Are you willing to help with testing/providing debug logs to track down
> > > the cause?.
> > >     
> > 
> > I submitted the dmesg logs in bugzilla:
> > https://bugzilla.kernel.org/show_bug.cgi?id=218255
> >   
> > > Though debug over email would be slow, so our best option is to revert
> > > offending patches until the cause if found/fixed.
> > >     
> > >>>>> Do you have to revert both cc22522fd55e2 and 40613da52b13f to make it
> > >>>>> work reliably?  If we have to revert something, reverting one would be
> > >>>>> better than reverting both.        
> > >>>>      
> > >>
> > >> Just reverting cc22522fd55e2 is not enough (and cc22522fd55e2 fixes
> > >> 40613da52b13f so I can't revert just 40613da52b13f).    
> > > 
> > > With UEFI setup, it still works for me fine with current master.
> > > 
> > > Kernel 6.7.0-rc5-00014-g26aff849438c on an x86_64 (ttyS0)
> > >     
> > 
> > I also built from current master (still 26aff849438c) to verify and it's
> > still broken for me.
> >   
> > > 
> > > it still doesn't work with Fedora's 6.7.0-0.rc2.20231125git0f5cc96c367f.26.fc40.x86_64 kernel.
> > > However it's necessary to have -smp 4 for it to break,
> > > with -smp 1 it works fine as well.
> > >     
> > 
> > For me it's (always with build from current master):
> > 
> > -smp 1 -> it worked 5 times out of 5
> > -smp 2 -> it worked 3 times out of 5
> > -smp 4 -> it worked 0 times out of 5
> > -smp 8 -> it worked 0 times out of 5  
> 
> 
> I managed to reproduce it with upstream using fedora 40 config as is
> (without converting it to mod2yesconfig).
> So give me a couple of days to debug it before reverting.

Actually here is another report + analysis explaining where the race is happening:
https://www.spinics.net/lists/kernel/msg5033061.html

That's the reason why my minimal config worked
(based on defconfig where CONFIG_SCSI_SCAN_ASYNC in not enabled by default for x86)

While distros (at least some) do enable it.

> 
> > 
> > Best Regards,
> > Fiona
> >   
> 


