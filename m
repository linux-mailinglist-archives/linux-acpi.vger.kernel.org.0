Return-Path: <linux-acpi+bounces-9719-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E799D5335
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 20:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78362815CF
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 19:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849621DD9A8;
	Thu, 21 Nov 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ncos1WVO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F311DD885
	for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215272; cv=none; b=QKIe+KEQkrUYDQlftq9MgY/KmeBkGuN5fSYRjG/rF1mHCrYGjyJqw8M8JouZOJQMd04aOOsblibGsidqWaGDcehnouERDwc50rDAnlYVw1kbCdmeZGDgz/7OZfLaFLmPSn23R/HJjB75GUUU1Gk7pUztCNHu9pkZdiCx2ku4faU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215272; c=relaxed/simple;
	bh=1YPCn9zJJS4aEfnFmVlYq1c5Rme4ftV6YZCy6UiFw5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBu13qNOZuOr+S2/hbf8h2rRudHkqEB036yEzz3SDp3Qc2inL+aYCnn+lF/KL9YD1C0iP+WOZnWKJ9RrnU3+qxHCJ68Yb2A4dx5qzHbcwvShN1L+491y71cJ+4WB2pCcJsgo1TaEJzHqujHCYYVDyw5GvtJOFMEvYM/v2dn/OzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ncos1WVO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-211fcadd960so9231775ad.2
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2024 10:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732215270; x=1732820070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tVo/3gvYEDND0rD37osncOuM3Oyc9/1OV2rDKG8dQow=;
        b=ncos1WVOInINio401qms1NaRBBUfuKo+o37RzI3J8S7HuvjUCUA1TQeBF8cZIVimRB
         ph3re5mFwmatJkIVCds/LLBzY3hz17HDSUK92Jt+ghcYH5OvJgS7sVANlIDsA3/AF+/Y
         Klkp1PAwuBjGRRx94b+DbEXP/mkrNuHeEtVtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215270; x=1732820070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVo/3gvYEDND0rD37osncOuM3Oyc9/1OV2rDKG8dQow=;
        b=jSPWxOA425mxyCQXx1hdA7Nu48hg7n9sK+wdtpOIV7I57X5Fq3jsnaYRAZ8rIi7EgW
         fdjJ0bN1mjLpKUYmoAxImVLlKJabOwZu+LnNcnD88Qr1Gk9vHAN/BoBbXSNYhNkhPF6E
         dypAlTRVwK7cZ2uJgS57CNmv5tolYC3bqBhE+O5qQEouZW2L3Gf59NHpWst02hcsa5r1
         QNgFsyJGEYxhDxENKnVuMXZNac0A6b92fRK4PMrL8pxLvVwLYEmgPqOdpHuPE3ooJ7pp
         fuBXqoeUmqGCXkXeZsRr9snVTihIhX44cFYQwbtHZiZq9eWiXhslAcIcWtwSw8vQzeLE
         38Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVrkdO3rPGp7pKHLjtxVPPmRLfHB7fDPQ/BM+bYS7qiNJwPdiG8E89I0iT86Pkgd5muZIBlhfxsn5Zp@vger.kernel.org
X-Gm-Message-State: AOJu0YzrIbja3hLSA9gNuS0tpCNPFvkLhc279v7aQ7Wvls96U4HZzWtz
	vz1VMsfsss3MW0+FXmiMIcwYEQpNYQW7C8d65326B7KtGiM9cyILgDqSh3bbjA==
X-Gm-Gg: ASbGncudaVJnb93pIMpT5Fk87hFxGWV1rKJOXg/A4IRC+C4BcYDUKVHpNt3BpTTX10k
	xhYJ1esnOR/xAaaV2zhiUfSx80gVzjFwoxRVkEjyi2HSQf/5dgAszgCUj4EvGif5OlJdaTOrh2I
	Rb3xHzGWiR6A9Bn3/soqh3ITWdLuN8sFjzBqQEeX0INBfJ5PXbuE6WdtspnwyWydiWFXiSW8h/Y
	PL9P7Z/cnfdP6pyN9UqMwVgTS9cRVVOvJoemWTOa3Pd1XPUHsOjbH0H5B5YAng8/54uUJpcWUTD
	zrEEeTVRWUnx
X-Google-Smtp-Source: AGHT+IFwDhiiYxF0PoEBXjjEhwecpiAmAyU2t8KXrUR/0ogHKZJ2FPPWiWfHYGwqBhlMKTMk4/OA6g==
X-Received: by 2002:a17:902:e88a:b0:20b:7ece:322c with SMTP id d9443c01a7336-2129f23b036mr2790085ad.29.1732215270160;
        Thu, 21 Nov 2024 10:54:30 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:6485:23c4:db3b:3c93])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2129dc12917sm1576015ad.185.2024.11.21.10.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 10:54:29 -0800 (PST)
Date: Thu, 21 Nov 2024 10:54:28 -0800
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <Zz-B5DSJx6z_FEQ4@google.com>
References: <20240828155217.jccpmcgvizqomj4x@thinkpad>
 <20240828210705.GA37859@bhelgaas>
 <20240829052244.6jekalgshzlbz5hp@thinkpad>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829052244.6jekalgshzlbz5hp@thinkpad>

Hi Manivannan,

On Thu, Aug 29, 2024 at 10:52:44AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Aug 28, 2024 at 04:07:05PM -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 28, 2024 at 09:22:17PM +0530, Manivannan Sadhasivam wrote:
> > > I can, but I do not want these cleanups/refactoring to delay merging
> > > the patch 4. Are you OK if I just send it standalone and work on the
> > > refactoring as a separate series?
> > 
> > You mean to send patch 4/4 standalone, and do the rest separately?
> > That sounds reasonable to me.
> 
> Ack, thanks.

Did this ever happen? I ask, because I'm also interested in supporting
D3hot for bridges on device tree systems, and it seems like there's
pretty clear agreement that pci_bridge_d3_possible() should not prevent
it.

If there isn't an updated posting and plan to merge yet, would you mind
if I submitted one myself, carrying links to your work for
back-reference?

Also, I had some questions on patch 4, as I think it places too much
restriction on how the DT should look. So I might tweak it a bit if I
send a new revision.

Brian

