Return-Path: <linux-acpi+bounces-12096-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFEEA5C8E0
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 16:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEB83B0CC3
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 15:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E5425EF88;
	Tue, 11 Mar 2025 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VYO/eUhe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26492232792
	for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2025 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708354; cv=none; b=JhgNlqojErKEk0yxp2AKag9TtHoZ+sW8wZHO+zaIwV2GdVTUflu91ugHZIuiYUrZEWU6XShRcy48IQPOp9IJQO6ln8TLT3F6/SXgatZudN8ZcUEKVltP4XqNGxn/MdosO/lXH2eFFRXKEcQLSkkcu7Kf+lGrtSHo0nKZXuxw+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708354; c=relaxed/simple;
	bh=FPduvMRu5TYi1K1LKfXtYoKzijOfY8eIT+viX2Nh0JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9gSM1gD7tGJKM+Bsfk1D1gMC7Mh9yrdTfgOFwHmokyofmvslXg1TPe40qrDVFjRp+525Dv7XUhCJibigq8CBflE49F/xCvyrmJ5pm0dp9EuxV0o0AtlVf9WNJo/tGy06FrU3W3S9eav6twLQZvSCbBuZp6JzHaBOqFSYdwvd8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VYO/eUhe; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8fb83e137so37109146d6.0
        for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2025 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741708352; x=1742313152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8HoYccd3vc0eOkLLFXVggkEWQ1YBV0cGpC5R0hATac=;
        b=VYO/eUheJsCvCUAvZArWp6VW/zqfAEFWGmlArwbpUVVb368y/JwkcJFUa58RWQx3BV
         M05mTgh8+nZZ0Mnu4H9OMTraI86PTj99oD8f9VAH2caj/czIUHFPYW56ApughzLLR5Yd
         slIh6cUn+Xq2UbP6/49k846I8gF6CjhugggBBy83ZzJs06b4LCpyvoM0VJ05lrqjYWS8
         8/1SIcuoEvRA6kk6xsjhHLSvhtVk9HR7uEeEpR0AViJi8fke8tmttYBYrTlQ1auHgUHj
         Y9ks5Pqn2H/1rJNDyabgvRaiHLaek7Tpvj3JJBtZZc7m9ufhTKpXBMhIQcHi1gPYET6U
         62ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708352; x=1742313152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8HoYccd3vc0eOkLLFXVggkEWQ1YBV0cGpC5R0hATac=;
        b=avEG2da7mzJQyGIvolBqAb+/njppsOhM9sgHjn2VwSElrWWONPLN2aAYVuU8Ss1rRE
         YOKQX9NXPcOJAaD3aOh3/XYr6n0uRbZFZ48qZwV5y2VQtByyvcVpnsuwIRLpwFzPi7aN
         dcqED8ZhdVD5MyptPGZmBZyWGOQYpmMjgfEraCEVBO+Ne36eNE3yslhjn3J/PcgxjwjJ
         oU2PAUYvnnz+tu8EEE7YM81UdxxuYSSsuwi0l5ItMujsUoU0+oRzxBbvNWaPdIwZ0OKN
         qoJqCTo//fumvXzDRpOHxr6p1jHqSKz6boq/KYFJP+YOJ7JLoGtk+cStPZIszVgCYgmV
         BMXA==
X-Forwarded-Encrypted: i=1; AJvYcCXGSV8KqM3owAgsFQOKPVxEaxkkhilS7pspW2hZbU1umx14V8eUkPaAHXfWyDKYbYY7W2dC7+5ZvEZq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+cIvNMHZmB1aimycSok/3IwzSwslPsJcIzZV1f5VjAqxq8SXX
	JL+edU8QN8vtHS4jio1XWTdZh7e5ehWrDRmrYazbAqnF+KVLDxL0+ZDPQD+fwNI=
X-Gm-Gg: ASbGncsyRf4U167ARj3HSbHCQaF5vVfVFRdBIAZdRV24pEAVzMjXF2VdL2A+u+9zhr9
	4ldl9+bG3V6bRK/Ab1owPxpvC74OmjdAVDIWcTbh08m62e9gs9BhvLSQR6sz9QPyfXpbrjHDG0s
	L5j2BAMRrZdPduMDCrxtBIoZzTL5eEPieyaHJF3ifvgDreUyUzUTENQcz7l/HuK/08c3DOJ2r6j
	rbYGD0eLKgXwnVff7XpBMU/aTYiiN33438myyK/a7pBzCLOQSjYO6lSAO1TB6TidaE1WKyHvKtn
	4KjISz0t22AZBTBxH114uG1SpSnFTGDUBaykZnLvIkFgIqU5B+8a1l3WBILsOQfG8/4Zy7wRaAq
	vBmaIHIupFajykyQl//2Z/anLhXA=
X-Google-Smtp-Source: AGHT+IFrTWYRzseDaLv+236WYx8xCV47HPkX/s3N848H/OkBnKxJZ7H9j4+WCaUF4DJ0EqjSGXHc+w==
X-Received: by 2002:ad4:5cae:0:b0:6e6:5bd5:f3a8 with SMTP id 6a1803df08f44-6e90066bb55mr239519506d6.29.1741708351943;
        Tue, 11 Mar 2025 08:52:31 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c5dcsm73466146d6.3.2025.03.11.08.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:52:30 -0700 (PDT)
Date: Tue, 11 Mar 2025 11:52:27 -0400
From: Gregory Price <gourry@gourry.net>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
	harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
	gregkh@linuxfoundation.org, rakie.kim@sk.com,
	akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z9BcO-CEDHqegZvD@gourry-fedora-PF4VCD3F>
References: <Z8-_SXm0JGjXTegL@gourry-fedora-PF4VCD3F>
 <20250311095151.446-1-yunjeong.mun@sk.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311095151.446-1-yunjeong.mun@sk.com>

On Tue, Mar 11, 2025 at 06:51:45PM +0900, Yunjeong Mun wrote:
> Hi Gregory, thanks for kind explanation.
> 
> We believe our propsed hot plug patch should be added as a hot-fix to v6.14, 
> because it can be addressed independently of auto-configuring feature.
> Rakie will send v2 patch soon.
> 

I think having the answer to at least the following question documented
is needed.  I'll wait for v2 to do another review.

> > 2) We need to clearly define what the weight of a node will be when
> >    in manual mode and a node goes (memory -> no memory -> memory)
> >    a) does it retain it's old, manually set weight?
> >    b) does it revert to 1?
> > 

~Gregory

