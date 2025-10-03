Return-Path: <linux-acpi+bounces-17564-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD31BB72E4
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 16:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9360A19E7F78
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571E823875D;
	Fri,  3 Oct 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pHIfItoT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6383207A22
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501715; cv=none; b=CAnJxdGttulCb1fGjy7pEI294YSIPyA+wOLAhzgSbxfGykbsK24g+c2Il7QrVqDdtLIeqtBCSI2IeJz35sLA8nFUavcCu/RyyAg6YBpHzgW3yt+BGi87pM6j7TQuoiTZmpdl0383W2FRIH3yKjmMaJYTXA0VdVbXi2SVRWs1WZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501715; c=relaxed/simple;
	bh=ezPNEZ/IJFqSQ+puYoLRYru6SDkIr4R+J3IIgGJZEDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evPCBzNJmrYyjG8YGgw4ACYV/pQaLzdrkgrFMZlmoq89G7EktBFFosz1H4jBUdeOQSG1Wvml4POy7+sVkrIC9vIu1hwsgMuh3vTdk0Z93FajuSukaB9Kt+x7pZE3ieGFwAC9sRslvczxzadd3JvsQTVUl+Tyg98YjxoVyEzHwQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pHIfItoT; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-869ecba3bd2so252070185a.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Oct 2025 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759501712; x=1760106512; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jSkC//pyzN8DkO27vm1eJ5t7cdX6GtvZ0FN76acbnVs=;
        b=pHIfItoTrinMsVqESM6JspIwtJsiY16ZVAqygfSB4MHuP7s29dKKDd5NDQo75zfi0m
         cXClk018vqZeeO2QANylhVksI6CPwzqFOXfbsMB0YP7J8pLTDUjWoE4c7jsPNng2y/8A
         Kr+sYYraKRdeP5c3ZaFb+vMGLuEktws44aKGIl2ShuN1Sq+Qu6RbZS3W2OGYefGFdLc0
         54ZJ5kJEQbQK5lXcF6xJ1EWb3sCK9bspiefzTQJtGebY7ehYm0Upgs22go4+N+YjsD/S
         +wWFS1eqXgogQxeimFRDB4JXH0VktA+6cogmAyn0VOfNZgiTakVJ8vxFEnlCAwei60Lh
         vn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759501712; x=1760106512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSkC//pyzN8DkO27vm1eJ5t7cdX6GtvZ0FN76acbnVs=;
        b=s+QWkJcq9JC9qPYQ8LlVhjpSgmHqbsi/IFwWfeUIaRyRKmYKh6GQ5qaMoYdfU5oEca
         E0+rpe2SRHtEy4cwBVbdjYYUqwFtXLBYTVG/lKRAboP+ghfMke7USPKXXJ4kcK4LqwnD
         aFqrs4och2r300F+K02qbKBp81fXq+GAmqQoataFdr5L9+JONtpDbhE6AMHw1r546hd+
         bv1NrTJRv7opZMZKF2Fd91HBO3h56NHpZa5oYc6wK/ex/5q14r6JyPNs+5MQ+XICoOM2
         Lh3iNtxShGKZOhbgxVs9fJYFHT2helNUjmYQN/TU7wPsDznbAlC9PQfX9niWyEqgHv0U
         Agyg==
X-Forwarded-Encrypted: i=1; AJvYcCUXEC3ZEVEK9CdbLO198g0rV6KCjfg+OPIUzBmG27BYSHftGw7puFNxbX/TUW5Xg6P4upIKNhexF1Bh@vger.kernel.org
X-Gm-Message-State: AOJu0YxtmJgcAsiT7k8DApyVY3Jz1zlRZVWMiLEaOPNwzPI6aAVrGISx
	cYfe+IvKRN26nZ2xTTYA8dgcFPN/ywhC+m2dPfCdXKt7jDnLt8M8hEBNMJqpNtRA72g=
X-Gm-Gg: ASbGncttDUNLZrFbQjVO8lTYSYNRUpb6OMq9KC6iXqzZsvhN/ZquLHZZbuSWYF5fToa
	Uq5i961OjiF7c1AhMu0Gu4M96RysWXj+V8/ESb+2PyGe5w3W244l78FqoVV5J6RK8sI/8kf8t7r
	qp+I2fDs/FWWEZ6C6Vf4fdocQzRx0x8od3uhaZWSJ4MVFbNHFVPLnbTjISqzn+zJdMu8T5M2MfJ
	BSFbr8sl9cskkmRBCgWOxlUdl1Ii2ftEC1BaWbfgXMuVEg+OIfNWZML1jFkp7gUu1htwgVELeZE
	T0kFRRYi8OxFcn1yAnSbK4esySixEMP7Wc1HT/3FmFu3RPPZOUB9AZsodqeHcg/L2E0jOHfDgI7
	TFAh9XtK/zdSlxSs+JMMXui7cHlMJXt0d7+lH1GffBU/4sr1SWb9oxEeeKlTMfZt2tudfyAPdNW
	F0P/ePzwyWUOe6G/2FXUEh3l9av6o=
X-Google-Smtp-Source: AGHT+IFmZUi0hUXGPsDtYIINOMocKKfxwRPSDcyJQoNDReTGD2RJGHxokJ1tsn6R+c3XW95hY9Axtw==
X-Received: by 2002:a05:620a:4489:b0:815:dab2:1ea8 with SMTP id af79cd13be357-87a38f08966mr387406685a.79.1759501712450;
        Fri, 03 Oct 2025 07:28:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55d0c8a57sm40352021cf.37.2025.10.03.07.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:28:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4glo-0000000E68Z-3t8X;
	Fri, 03 Oct 2025 11:28:28 -0300
Date: Fri, 3 Oct 2025 11:28:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
Message-ID: <20251003142828.GP3195829@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>
 <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
 <20250930163732.GP2695987@ziepe.ca>
 <CACePvbVXZ-rPmBi30eAO-2oF5K5hzQqQPo17M6hV7Pn4Dxrg9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbVXZ-rPmBi30eAO-2oF5K5hzQqQPo17M6hV7Pn4Dxrg9g@mail.gmail.com>

On Thu, Oct 02, 2025 at 02:39:26PM -0700, Chris Li wrote:
> On Tue, Sep 30, 2025 at 9:37 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > As I said, I would punt all of this to the initrd and let the initrd
> > explicitly bind drivers.
> 
> You still need a mechanism to prevent after the PCI bridge scan,
> create the pci_devices, not auto probe the drivers. If it is not
> driver_override, it will be some new PCI API and liveupdate is the
> first user of it.

Yes, we need userspace to control the timing of driver binding for
Confidential Compute too, so I would prefer to see a generic proposal
that can solve both.

If this is to be a luo thing then preserving disabling driver auto
bind for specific devices could be reasonable.

> There are two slightly different things here:
> 1) modprobe the driver. That is typically control by udev.
> 2) auto probing the drive after the driver has been loaded or PCI
> device scanned.
 
> In your envisioning, the initrd autobind controls both of the above
> two spec of things, right?

Today the initrd runs udev which does the module loading and then
the kernel does driver auto binding.

You'd want to move driver binding to userspace so that userspace can
select which is the right driver for luo and for CC we want to delay
binding the drivers until after userspace has measured and verified
the device.

The idea is that userpsace, through the modules.alias file, would run
the same driver selection algorithm and signal the kernel to load the
driver.

Also, for VFIO we have addressed Greg's remarks about driver name ABI
by adding VFIO specific module.alias entries:

alias vfio_pci:v*d*sv*sd*bc*sc*i* vfio_pci
alias vfio_pci:v000015B3d0000101Esv*sd*bc*sc*i* mlx5_vfio_pci

Modern userspace is already supposed to be entering VFIO mode by using
this file and avoiding making driver name an ABI.

Jason

