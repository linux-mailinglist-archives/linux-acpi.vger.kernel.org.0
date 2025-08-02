Return-Path: <linux-acpi+bounces-15470-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC8DB18EC7
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Aug 2025 15:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A82D3BE4A1
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Aug 2025 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0030623BCE7;
	Sat,  2 Aug 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EzeXwANA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A20E238C1A
	for <linux-acpi@vger.kernel.org>; Sat,  2 Aug 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754142638; cv=none; b=neGj976RJ5Hk8ajA9C1epz/R0YdGAUEFIFIm4FPCzkM5QyMNN9ZOVK7N3R54y+FiyxdyZDZZkYHFg1RYJPRzkJPyOa+SfuK9PE6ejVYN9XFGfqjqrNfHrGtdMa6brPGA8YQYBsjpeMts/BEQJH1ww0Rp6qPj8adQ0LDYi+D8GNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754142638; c=relaxed/simple;
	bh=LuZKFpWuGGzaZA5PO666vYIpjfV7fVYnGa8m+zu7hYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqmaGIGQR18AMsI3MzUnyZewRygaYUA+aUDABOhMMWaPDjzp5AYll23O8lu4TDkMR8FNADHASwYYwGuUbu8yh0TwF7ioZh2uXZfZwgAmeKTJ+BdQePw6GIPydjD1PqvL4jdXd9uT8bLDO/ZnJIwGHrOlBV5wVRlgxJfreqXW+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EzeXwANA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab8403b6daso27257391cf.2
        for <linux-acpi@vger.kernel.org>; Sat, 02 Aug 2025 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754142636; x=1754747436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fuk2lxrqPOrpRrouda4o7p4C2uIw6lx4ISriZi45ts4=;
        b=EzeXwANA/LFJXeWiL5EANqVgjd7j0bHOI7NqR1mJQQcXrf09J8mV3uZhixOipku761
         QTLqZEwdsbGnSwDuR070Elu+R645I0zWgFv7WK7v8Fn0EsQXr8rgiU4+M6C5X/o2ozfn
         uBB60cLP9ayh2ZC/EYMkpyuUKYchCEgs/knhRiOzFRhPI5QTUsr6ZyMMgtY2kmfuxxR5
         bU9aR95ybjVhVQa4+B0lS6z4e9mpt971cm+O2pKxXgp2q4OKGSxugg2010dG7n43Dh4/
         aR/HBjsVWWVFIR9KZ3n9PHYwkiSFvPfsRpUbvKAgiPQ9PcYnw7jM1BbmYQ220WzhB6eU
         xD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754142636; x=1754747436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fuk2lxrqPOrpRrouda4o7p4C2uIw6lx4ISriZi45ts4=;
        b=TAwD93HcynFv1pBj+FYX1kqR/2pjA+RYLJmJbChhEmLAzbuVPF95HUNeMRZhpLzdHN
         UQeItjqJdojKGyyY86Ah8YXJnkNG7La5+W8rLJvxxsc7unzn35RXkT63rXNzQT0sT7YD
         fZjO2kzX4ASpJjOY/DOil6dI3X9XQsNAT4bAaIbygE5UPB7Fv9fc2FccGz/s1QS0F/iU
         GiLOOEJ76qfZOfWPcLw6/Eabjx8L9H+k6jhifq9BNbPEocP12XKCdrfJiGVXnHMMaltC
         7aJvtF1tbHb/zOpkT2/hNQrQ0I1ajBJMBUW0GCqYaxSKZvS/f2fFVow0/uKptTV9i01V
         9jXg==
X-Forwarded-Encrypted: i=1; AJvYcCXHdxRI/ln8RYjM/wtFjGTRLDk9rbwiZ1hoo8XKtlN7KzwpGrG+pBTY2Cxz9rc2zbOjRaZaTJ5csHdU@vger.kernel.org
X-Gm-Message-State: AOJu0YyetpR5EreCZHfjF8FO95xPtbCPqvHAFdlyQ+s9UYxWWn8XYGhg
	hy9WaSaWVU6LhfXvpyVsnbrnS7oLBq8hlfhKwbuaVppbTMeQrMif+zojHyZbNzC3I4k=
X-Gm-Gg: ASbGncv4vk7rJZwqrL46G2fyMKXP4UingdhUJb7n3HyOoR8NnKZg/H1Zovk4s5YFB4U
	G63mOTwf0Mi6MllKFraP9qW62JOhMsn6o2vPja737YtUKgVZfFJ4IhWesPb4TQmv8aEgJBejjsF
	Sp4rHCKtOqShdkb1/ttXuzbSOuVWzWyhND7ouJI0iQSdbYeM/irwe4/zHAgd6EcxdrulwRU0tiA
	yVY0RGFooe/EnX+UfkNxu6Z5O/DEAPmxBvs3PJjaqioWiU6UwEkd879sQQgPEOZ+1abeRilN83W
	V/P9yS1DqWFWlj0JQIex3uXCIjucTb4sB0yG0r0bD80LXJoUeMLkrsfKoKohQlm1NoC7EZbPDzE
	jwCwTo/6y5l60oi7q3sd+5Eb0SArdBAvx2juMjny8D6u9vDc5QkqG3Ii4nUww6mFioopJ
X-Google-Smtp-Source: AGHT+IEpsAH58cOIvisp67GeJBP3mYHAiMC91cTAnICy/rrQ4pDbqvjQWBKRPW9T1q+TGAIxQC7cxw==
X-Received: by 2002:a05:622a:1aa6:b0:476:875e:516d with SMTP id d75a77b69052e-4af10aabea4mr38643861cf.36.1754142636187;
        Sat, 02 Aug 2025 06:50:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9d8affsm34886696d6.5.2025.08.02.06.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 06:50:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uiCd8-00000001A65-3qAw;
	Sat, 02 Aug 2025 10:50:34 -0300
Date: Sat, 2 Aug 2025 10:50:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
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
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH RFC 20/25] PCI/LUO: Avoid write to liveupdate devices at
 boot
Message-ID: <20250802135034.GJ26511@ziepe.ca>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
 <20250728-luo-pci-v1-20-955b078dd653@kernel.org>
 <87zfconsaw.ffs@tglx>
 <CAF8kJuOM=2oEFP20xWtQ==ECwF_vNB032Os3-N12zY1xVau-yw@mail.gmail.com>
 <20250731150132.GV26511@ziepe.ca>
 <CAF8kJuPbJWea+o=GTFEM6KRCq4DxDad+83+vM0Np+n=Mmzqzag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8kJuPbJWea+o=GTFEM6KRCq4DxDad+83+vM0Np+n=Mmzqzag@mail.gmail.com>

On Fri, Aug 01, 2025 at 04:04:39PM -0700, Chris Li wrote:
> My philosophy is that the LUO PCI subsystem is for service of the PCI
> device driver. Ultimately it is the PCI device driver who decides what
> part of the config space they want to preserve or overwrite. The PCI
> layer is just there to facilitate that service.

I don't think this makes any sense at all. There is nothing the device
driver can contribute here.
 
> If you still think it is unjustifiable to have one test try to
> preserve all config space for liveupdate. 

I do think it is unjustifiable, it is architecurally wrong. You only
should be preserving the absolute bare minimum of config space bits
and everything else should be rewritten by the next kernel in the
normal way. This MSI is a prime example of a nonsensical outcome if
you take the position the config space should not be written to.

> > Only some config accesse are bad. Each and every "bad" one needs to be
> > clearly explained *why* it is bad and only then mitigated.
> 
> That is exactly the reason why we have the conservative test that
> preserves every config space test as a starting point. 

That is completely the opposite of what I said. Preserving everything
is giving up on the harder job of identifying which bits cannot be
changed, explaining why they can't be changed, and then mitigating
only those things.

> Another constraint is that the data center servers are dependent on
> the network device able to connect to the network appropriately. Take
> diorite NIC  for example, if I try only preserving ATS/PASID did not
> finish the rest of liveupdate, the nic wasn't able to boot up and
> connect to the network all the way. Even if the test passes for the
> ATS part, the over test fails because the server is not back online. I
> can't include that test into the test dashboard, because it brings
> down the server. The only way to recover from that is rebooting the
> server, which takes a long time for a big server. I can only keep that
> non-passing test as my own private developing test, not the regression
> test set.

I have no idea what this is trying to say and it sounds like you also
can't explain exactly what is "wrong" and justify why things are being
preserved.

Again, your series should be starting simpler. Perserve the dumbest
simplest PCI configuration. Certainly no switches, P2P, ATS or
PASID. When that is working you can then add on more complex PCI
features piece by piece.

Jason

