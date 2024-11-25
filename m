Return-Path: <linux-acpi+bounces-9776-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FAC9D8E9C
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Nov 2024 23:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B818DB29A4D
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Nov 2024 22:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D41D156F3A;
	Mon, 25 Nov 2024 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bmy3a9g7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED351C1F20
	for <linux-acpi@vger.kernel.org>; Mon, 25 Nov 2024 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574150; cv=none; b=SG5eiq43QeGBqPF/sr6jTmHstBMYPZepVAZ4fbvh0bkBl8sk0aK+cQTgWzabnrke/nwRl67Z04iLNRy46Vkt4z1kCzhM+G91HY3gN4e9NqPYkSbN+tHwU6cX9C/CP7MkHNHt/4m+pD/qxQacNyf5w4qSiTqW2OPvGNV15j70yeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574150; c=relaxed/simple;
	bh=3rZk83BFapNTYSBmR45Ri1F6BV2vIxTmxP9C/qJIk3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBkWE5BUc2AJ/K7/s0rykuVfxqoLWKMVI8BYIFAB5xrfncRT81O+oXMjcRFDOfyF9szoC0TZLb2mj+YnRnwuHhOQ6RAr1AMHm0aWgCiRFxHIg4yE8bV9YCWXS3TDF1Q8VpCH0tsKFG51uhdp1VJahDQVbZQITHEU7SC1qr7QWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bmy3a9g7; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-466929d6013so13958471cf.0
        for <linux-acpi@vger.kernel.org>; Mon, 25 Nov 2024 14:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1732574147; x=1733178947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F0LEVVmh09qWTmRbUUXnS8M397YMXluTgjzA1Orh4xQ=;
        b=bmy3a9g7l3vx+n5XzpfPuVURidiAr7SCb3Jx2iua8cP1S26eoskIAzODwCqpCRK2lq
         6H1eTsN6vMhDzv1OeqLP8Pe3mOYDtVcX2lkqMoLYOsamRlZLR798a03Pu9pH+7ToZB7R
         BckPEXjV//WboJlMAzxycaHzdU6olamSGgaPEviGzqybS9tPcFNs+F8X5HIyQhoCrHc0
         sUJe6XNMKtANmIIXdzKSIqYlOoV92qpBnMshjcbV7qTECR1a1bXWEmp1SnbziviQbYsa
         HAOee697Itt7oe25TPx9rqync05qV9+IMX8zpJhdZpilNGcQ8VO+sJVRYmHesxvSC10S
         66DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732574147; x=1733178947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0LEVVmh09qWTmRbUUXnS8M397YMXluTgjzA1Orh4xQ=;
        b=s68A2TwIRy/XDLwnfHNFRW54dDdJFkkASODZwl7pRIrat51sX9fOkSi9d9GEe3MHYt
         oORBbBSDHZ7gtAeI7xvfN1V8aPWDnpiTaB6vUmfgksb9CUEbIjCJaFnIm4rssBB2tmAw
         2x0XXYY6S2P5I35JarUN14IgR4ixADoj34S8DWVy8pOPT1N4Ag8BnizTG6lL6Kn4RY53
         vPBXSWbPNJeX9coypKTjLxOOtoqCMbI63Sl2hYIR6NB/h+MhYXc6qbQsNb5VNmqE/4vS
         LKVE+RbFYDa8XJxxN7U3AT+0hqTMySa1BaOW+O9Gc5GdwckdkknbOO1o2jhNtKAl75Af
         Q7/A==
X-Forwarded-Encrypted: i=1; AJvYcCVLmZoRq7FKmdiOdbq/zInWLi62va0GraLHsaAXW5uJ+1OhfeReqtxRScR0K9hag0/7PX1cAsEDCYnt@vger.kernel.org
X-Gm-Message-State: AOJu0YwYKZHpaKOz4WoUkDlIsR4oidVU5D5bROpOKv98sxLgYn5tCCUz
	5vvWZ5kmGkoHHcAhHx1P2odziPzQztc1JuB1EscuZ6l/G0IU43hdc6bfDnImoZg=
X-Gm-Gg: ASbGncswhX0GaggAxTF/qZrdVMhK82pqCIPnoDS9v7+URr/rgTP6RDezlpRMI48IG2L
	wtEDO+zPp+NMcBt/Ft7+bp5IMvoUOiwueCt8v83pW8GIkJVfH5k/G33rCIc+M24f9S97yIPqNur
	sgI2ec7NCUdxw1dk6sqs/509NkCSr6Y1DB3hv+QaF1+tIgTWYhDM6crALYigRWCiR+bdXI+KWXi
	+9rDd+7QDyqzOnKNny6WHBurt+BDO8ec/LNP3eKmYaMfsS3iTkOQjPkYd51/XDcIy8kWEwW2nWn
	07YG5aWGp2zipYd1+/CCMBnH/eqKDSEybm8=
X-Google-Smtp-Source: AGHT+IH7fIwbkI4uH8JkSw8OIkc51k/5IJgozs97dQO+2GrBwa44CknCf+8EgNq+gOdx+sWFIvRlIQ==
X-Received: by 2002:a05:622a:1917:b0:461:1361:eb14 with SMTP id d75a77b69052e-4653d5225demr239121711cf.2.1732574147447;
        Mon, 25 Nov 2024 14:35:47 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466a47fa3f8sm2743791cf.69.2024.11.25.14.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:35:46 -0800 (PST)
Date: Mon, 25 Nov 2024 17:35:31 -0500
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com,
	Jonathan.Cameron@huawei.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, david@redhat.com, osalvador@suse.de,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	rppt@kernel.org
Subject: Re: [PATCH v6 2/3] x86: probe memory block size advisement value
 during mm init
Message-ID: <Z0T7s7_j0_FCtihr@PC2K9PVX.TheFacebook.com>
References: <20241106155847.7985-1-gourry@gourry.net>
 <20241106155847.7985-3-gourry@gourry.net>
 <6733c9d135589_10bc6294b6@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6733c9d135589_10bc6294b6@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Nov 12, 2024 at 01:34:09PM -0800, Dan Williams wrote:
> Gregory Price wrote:
> > Systems with hotplug may provide an advisement value on what the
> > memblock size should be.  Probe this value when the rest of the
> > configuration values are considered.
> > 
> > The new heuristic is as follows
> > 
> > 1) set_memory_block_size_order value if already set (cmdline param)
> > 2) minimum block size if memory is less than large block limit
> > 3) if no hotplug advice: Max block size if system is bare-metal,
> >    otherwise use end of memory alignment.
> > 4) if hotplug advice: lesser of advice and end of memory alignment.
> 
> This seems like documentation that also belongs in-line in the code.

It actually is, just ahead of every check instead of in a numbered list :P

~Gregory

