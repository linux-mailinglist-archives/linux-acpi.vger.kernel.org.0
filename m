Return-Path: <linux-acpi+bounces-17455-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6450BAE11D
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Sep 2025 18:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B733BD7EE
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Sep 2025 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1664B23C8A0;
	Tue, 30 Sep 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QxSog5oQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A97224245
	for <linux-acpi@vger.kernel.org>; Tue, 30 Sep 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250321; cv=none; b=J3dWnag/bNo+Yln7XPUoBX2efu7ggXHYt6QGUPQ9F3QKRv8vmzd+BWcswxnCscpvxQq94lcPwO2rHaIFVMEoDIzVXi5zEM+vGXbQIegQBbyfNsRAM8utVh0Cp22F1ND0QJoCmTdLnn2NLhfBvas6YKLSTkI4805vFW1vY2GclKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250321; c=relaxed/simple;
	bh=7ZvWWTmbwpz938UNoot7kYAQyxONzvQpdhOgp4f0kCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CktsD6+N4G+H0vVfc+09APrnVaL6mKxmb3P4c1+s4ol/txkYVDlrA0ymYmnqc1glhqQKP83DQck8yOSpQQqLlUHmKWKt03rUwVzgR1kL9Y2uqZcTYFahONVVS6uBauOVowu7IDqdeqW8GoElXSqPWfqfw62xWc5MhPF0C2HWCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QxSog5oQ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-869ecba3bd2so308865185a.0
        for <linux-acpi@vger.kernel.org>; Tue, 30 Sep 2025 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759250318; x=1759855118; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xMgANQFX+SgjbJ7utrDVcHclI2GXnTTwQrJXxesWGK0=;
        b=QxSog5oQqgvxLnngv8jU+x203/kOQ7zDjATvuDF14qUIVMjHN5ZldBQUXyEXnnU4kN
         uXewgRecH2LdxHNHyZPgIA7NcMm9IH9jwHBlwY+FVw5DfnhkOCQwrxfyatDiN8yIb3nm
         QjWuIdPAppqdsn0s7FbQW3Lqo4aKEwwFlL1rc1Sg259MIgyht5gvEcmREVej/4fgYIHd
         WDXddj5iajsW79DTuJIFWkkJA3ksnFksI0q9eMHcuHGly/AsvGl077KPsLj1bMDoj+nT
         AtB+pxM+QJM4OD7HgOVrAEXhgDdCgfCd9GBia/VUo9cS+4blIE4Cp6eVD9q681zKVQnR
         CgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759250318; x=1759855118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMgANQFX+SgjbJ7utrDVcHclI2GXnTTwQrJXxesWGK0=;
        b=W6sygldxq3e1JPER54BNVWXFOmVDP9lMxjkI1MMdMQUjkPwazr3vHI3c/CSCeSbhrb
         qPp/mv4d9SeMlw4JQjURmWh+FBqsud+LHhbImthOX9zKNrweqN7wJYP7FcwNYQ9Xg9yj
         klsNKW+PACh4QX0pcKVzjoSDOSixom/fu/lzV50jUdXEJvhWolQ6MiCdhg5FuqWREqFR
         bVsaT5DY4OXm5tjW8x4xDThbYi0YFrnkEgVaK8G+FbaD+eXC9nAq2Yv9OZ9ejob077hN
         iswj/QOHXskazFiKNdJlZEDytQ2nlbPwvAuV56MMcYM8Lru/1X04wRGTzIW9CtM3Ugw7
         CE+A==
X-Forwarded-Encrypted: i=1; AJvYcCXaHnzXZZMwhJVIM0KzKhGg9zQc7Zwm85lwybPMusXX+92kd4Rxba7/FjYYUea1ypZpCDs9COseHuc9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6YpP2Thlx6z3hrFP6gkTNqOn3qTQOmEBBHQwCrIkGnr/580Rb
	DP5gQx3ccR20ZinMIzemQHe8Iw0nA0Gr5+R89SeQEEgRWEwxzq2kcM+qKZBXdkXQo3k=
X-Gm-Gg: ASbGncsdXCbVJ/lk6KLJwTTAKXWKuLKqpSAFUmIcDru1PFxGFL4H0+qFbF2UoQQaWCN
	u0BK/ZgURCceSPg2i2mvUbpM2PSQAZIIsmRKmdYi/0GEEwqstlhjqxL60d59gQLoMmRs1FSw3Z6
	n7Tm55dy22pc+o2fImz792dW3/n+b14lzuJ/oXr9lomril+k7f8+2FH4b8kDWlEaVFTm5m5Eujj
	eUzW4BChN9Vb1gDMHtcZT3t2AvMaD0chk6g/8LzmzRgNAIEM/0Of9MJHR3UYkOVvVFkKwog6r+a
	FZwqWkEzhq7Uof4LlNRFLyEohSrOGmp0qhWe48cvzwbq/1MXfvQjN/g34NkQCnHTrOaYlTei+3S
	LSwUgEXoA8h2CgkNZCb83izeRpd58FTc=
X-Google-Smtp-Source: AGHT+IHPJOCF3mi5Y/iQEx0Qz4nnWU+loAsRCrx0f3/7Rw3nO0AV/kHYsW/UKUUR5t5JJw+wAlT2Yw==
X-Received: by 2002:a05:620a:4544:b0:85b:cd94:71fe with SMTP id af79cd13be357-87374cdab36mr68636085a.33.1759250318426;
        Tue, 30 Sep 2025 09:38:38 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c307ad101sm1065322985a.36.2025.09.30.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:38:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3dN7-0000000Cbmj-1CPI;
	Tue, 30 Sep 2025 13:38:37 -0300
Date: Tue, 30 Sep 2025 13:38:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
Message-ID: <20250930163837.GQ2695987@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>
 <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>

On Mon, Sep 29, 2025 at 07:11:06PM -0700, Chris Li wrote:
> On Mon, Sep 29, 2025 at 10:48 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Sep 16, 2025 at 12:45:11AM -0700, Chris Li wrote:
> > > After the list of preserved devices is constructed, the PCI subsystem can
> > > now forward the liveupdate request to the driver.
> >
> > This also seems completely backwards for how iommufd should be
> > working. It doesn't want callbacks triggered on prepare, it wants to
> > drive everything from its own ioctl.
> 
> This series is about basic PCI device support, not IOMMUFD.
> 
> > Let's just do one thing at a time please and make this series about
> > iommufd to match the other luo series for iommufd.
> 
> I am confused by you.
> 
> > non-iommufd cases can be proposed in their own series.
> 
> This is that non-iommufd series.

Then don't do generic devices until we get iommufd done and you have a
meaningful in-tree driver to consume what you are adding.

Jason

