Return-Path: <linux-acpi+bounces-17559-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A9BBB696A
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 14:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96E514EA62F
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 12:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E83C2ECD2E;
	Fri,  3 Oct 2025 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PWEaVRm2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCEC2EC572
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759493203; cv=none; b=E1Enn0L6deDKM06PTUkn7mIKoWa3a1+6lFOwK1S38BEF2umomx1Gkwk2zJDZxjI2kpTOjOAf0MGj6gtvrNACFQN3N5om9g4rdgT0/zrHHcYwKMKjxu84fOMAo3Mts2NeBN4hMXBbyWGRBWLTUwqG9ZGj1ZYHb+c3/pBksJWKdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759493203; c=relaxed/simple;
	bh=wSgcHRu4XVhLC13BBYF4OctryqDLWNhWswI6B3UGTCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLdo0TD1i79Gw/Sh7/qIqhydUjNq8I8NWVeDYgiu5YqBYwbvWbeegx7AZHiQbVtcdY3DYxYl5qyC6+hCHEPANZ2KlkzbPSxdY5NHsn6Q57gjJ0PtsBQEDkeW3ZcdibDk/4tszJveVtsXC2/nbX1lgF7eoJ1nOT46CDBiVq22jyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PWEaVRm2; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-858183680b4so275479485a.2
        for <linux-acpi@vger.kernel.org>; Fri, 03 Oct 2025 05:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759493200; x=1760098000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wSgcHRu4XVhLC13BBYF4OctryqDLWNhWswI6B3UGTCo=;
        b=PWEaVRm2l/bqBXatSPjD0pVs0Lid924vLnwvssIt2Zif2dfLuy9ykZyOesckpUe+U8
         nls4oiBmHl/E9KM4DbsLX7WUIXNvEUeJWMOPhbHSYyJ0uAz05mpbRhMVADuTufzowJDY
         5L/92m2ll2xQ+etp0PMZanea26e7dwrefolf9z00ILWbS7d6eKRO5bgppaJNPoKDOaao
         PiCLn2i/aEBHzjIISbFm4Ca77zuhzaBj4YamnJw5QqOLTeqEKW2KvK4hb7c58nLE2Z5b
         sv19Zp2E1QR/yX2+ckin0kVdUh1mRXUGvbRPrQNWeJBG/hzV31iR3SRTlKiQ3nq8IcSj
         XSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759493200; x=1760098000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSgcHRu4XVhLC13BBYF4OctryqDLWNhWswI6B3UGTCo=;
        b=O0/nYYYJ4NM61v0f0C+yQAoWljUnBfx7SYE3xdaDYqy+vFIWUUDu/j5jRgTO41p9Ph
         bGxYsnybweBt0UOpndSyAUKyLPkPsPhdmKEqLsJBe9gCFa5QmA1s9RhKou3NVBfUo0rK
         Ft7ildKQ/hqPHbEHFElQkQgYzI3u5vxOTDyDMG1AUdwhDX5y2ND42VtJYzgZSVs+143Y
         XaYKDfaKxdiVIaYc8/9fiK6B8DNEYOwZu6qtUCn5s9HxwKDEeSc3a9G8OKWCtVtcqAZO
         jt4zPJObRLEwrtWFoNWizazShxpZQi296Ssd0V39INF28SrV6zYySs3jO0BktdebDCct
         YQaA==
X-Forwarded-Encrypted: i=1; AJvYcCVr4U+GQTvYoio4czyYCSOx6/0p/p2FrTHhH0+88R47L/RBe0ZYm3Z4hSwsHxREWwxsIp5KtuvbFa3z@vger.kernel.org
X-Gm-Message-State: AOJu0YyjiBucJG7acf/eSYG+Dh+0eQiw7iIC+0RtR4FxV3ehnVorfulJ
	/vVrD0RPrYDqm/AvZI5OirYwWnGydRQNYFE8mpiuimb4WZel469p0JZ2fzp4a/mocZc=
X-Gm-Gg: ASbGnct5zTO7mE9Pbp3YjupnbfzhcUycjpt2Po3+m9wFxIFBlRsL5Fe6fk0+ShCkT1r
	guCWmvGVtygRPjCzRLR/YGOHdhyoIJNhdQY5mn/D5izTYwUz16wUEZC5dt6lvrTR/aomwj2rVpw
	EYsOuIP0jNmb6iAJDtxssB3J9XF4onF+2BltiIP3CcoDI9qRsuASHPXPT8E4bpxkNU9hVfjscVl
	5ZHpOYefnBIj3YHgfTTVNo4auOr6FVP7Oqilx/wiOHZo+MHWOgwXuftWHxkJ9q5rqhFWucugM8T
	HROGjUtbo7zTWqBeJTpX3ww4ET9krAwEVPiBU3NQtwl5zE+7trIBZyVcZ2CMI9ZgVsYo1JuSrLZ
	Rl9s/X31Oxu8AukfoDN67FyOEKmHJd0a8Aqbby6sCqKLXsFAyxBthVE+J5KVTN6aI8AqzPjGgbD
	WClzpNTPuAoyNn/n2wTeXK1xApxN3kl7DWVu0IDg==
X-Google-Smtp-Source: AGHT+IESD9NWxfSord5jCIA31803QVCClkT5xpnqBbd7V15YYn81ihEL+4lu2i2UsZSEnmpQdxOuRg==
X-Received: by 2002:a05:620a:2893:b0:85b:be19:653 with SMTP id af79cd13be357-87a39a943c0mr330432485a.84.1759493200373;
        Fri, 03 Oct 2025 05:06:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87772836c1csm407328385a.28.2025.10.03.05.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:06:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4eYY-0000000E4oO-3XXT;
	Fri, 03 Oct 2025 09:06:38 -0300
Date: Fri, 3 Oct 2025 09:06:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: David Matlack <dmatlack@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
Message-ID: <20251003120638.GM3195829@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>
 <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca>
 <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
 <20251002232153.GK3195829@ziepe.ca>
 <CACePvbXdzx5rfS1qKkFYtL-yizQiht_evge-jWo0F2ruobgkZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACePvbXdzx5rfS1qKkFYtL-yizQiht_evge-jWo0F2ruobgkZA@mail.gmail.com>

On Thu, Oct 02, 2025 at 10:24:59PM -0700, Chris Li wrote:

> As David pointed out in the other email, the PCI also supports other
> non vfio PCI devices which do not have the FD and FD related sessions.
> That is the original intent for the LUO PCI subsystem.

This doesn't make sense. We don't know how to solve this problem yet,
but I'm pretty confident we will need to inject a FD and session into
these drivers too.

> away once we have the vfio-pci as the real user. Actually getting the
> pci-pf-stub driver working would be a smaller and reasonable step to
> justify the PF support in LUO PCI.

In this contex pci-pf-stub is useless, just use vfio-pci as the SRIOV
stub. I wouldn't invest in it. Especially since it creates more
complexity because we don't have an obvious way to get the session FD.

Jason

