Return-Path: <linux-acpi+bounces-7560-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0619513EA
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 07:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14781C2341F
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 05:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE386F2FA;
	Wed, 14 Aug 2024 05:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dClfevc7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED956186A
	for <linux-acpi@vger.kernel.org>; Wed, 14 Aug 2024 05:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723613538; cv=none; b=BjeyMZGMTZUnKqtTjrUNQ6N+HQTdNh1ASOUor1ut6bAvh+Pe4DOqXjc+1Fr+piQaT7VQZSxdIQO6T+MZNcKNxR2OZ6RQCxhEz1C5051T2WiOGJeDk8sZZELNuO4WviK37XX9fDKdG/+8wijoboc3t9fjBiBwNalNvQ0L4otgpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723613538; c=relaxed/simple;
	bh=XWUT7Ncd4BhNORqSMjGJ4T2+gOtx/xZlS5w6FWK9m40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEiKob8MMoxKE//vMSRBEd7RTnI50MIBIqTSprN4pom38et3BdV6TS01dl/FiFtxNUCO2BTX9OF7aYBZYbGZHpFZQu7QYWdD7oc3uTnedj8Tghb1pzwZB97O9IYAq4sk4puF8ArOlh4CYyrYukb5J4EQxGgzUqASo8h9YJalaw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dClfevc7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-710d1de6ee5so4988173b3a.0
        for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2024 22:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723613535; x=1724218335; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MW1voiVkiK6ybB7ai4q3hjESE3gnEZP9taq8A0sM4Ac=;
        b=dClfevc7a9daJG/46xfSUqhth4P0PNwwNCAnZocFqs+3+Z8ovKXN6/xy5GccM0xB0D
         WevBeH2tbJ6ZaaDTmla+NXW6GCimmTsT0D7CLvIjpcEEkDjgGjEVcTPQWaH+0QB/xmiB
         eQePqQGn8tfRZiyQLKxgzZOtcFDWIG7hBHzFteAAW4GumS6yMPT3oHRYlLYmGwbUMDbW
         xKZ0+Hs6yYbCSSmbRfPo4uGgECfUkZ2F0LOOQc8E3paQsCkV5vR0SQbsRZXe93JT/lIw
         VIJJuC63GOAMUJAYDXF+wcqOvNCK6zioirwsMiWLkLoScHqLJRfY6oHUA7XcrGaWgGU/
         y4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723613535; x=1724218335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MW1voiVkiK6ybB7ai4q3hjESE3gnEZP9taq8A0sM4Ac=;
        b=KUM48jtZHUANQxm3fHEW7BxFZvv6RD3J9WO9PbRvick1JL4nk87Eq9vOsmFePxNBzP
         UCS3fRgJ9Pzn3SDvp7YhygxMS95RPTDlJEFYVn8QNjhUlb51y+Wnf+grYnZEXb53u1YD
         08oxI8f+GVKe47XRt4w5aNLb3UG3t6peqpBY4wutFAVa4/wy0Mkp6eghKLuoRnMcEFRb
         a+lB0aZuM+lDKCweb4hWmqzcLc8xeWjqeyZSGGO9uue/qrSyo1W3D8UCbSt6m1QWtsSZ
         BrFc42JpzH+OkPA+QePR67PaeknIyoC6uO0LHptuzF6Hd/zsxgtV0E5+tPANMLeAg7n9
         V11w==
X-Forwarded-Encrypted: i=1; AJvYcCUCUEs46EPrWrgYLSLeJW6awli4DHCMyWVTkQ8aZtlD1UL52CKIVD4mYQvxG87/Cxo3qiMWMDUHIqX6qIFLoKXSkWu7qg01100RPA==
X-Gm-Message-State: AOJu0Yxgu+Vgfmy/IwXLk5abvH+OptIqJJ3i9oVPKIj+QR+itVTWPijn
	hlcBntAF4YQDfFKKrG1PGAmq8ma2SQcZzpAf0Vyz7iCA2kr3B3ElYm7dfUeB/uU=
X-Google-Smtp-Source: AGHT+IG+HZ5EWjYic/b5QeOk5+VPgQJcNuvLcWtvoSZVAm6KKwkjPRIE2/NWQY79ieZs+RokBTE9nw==
X-Received: by 2002:a05:6a20:9f44:b0:1c6:9e5e:2ec4 with SMTP id adf61e73a8af0-1c8eaf8b3c0mr2418490637.50.1723613535290;
        Tue, 13 Aug 2024 22:32:15 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7ca35fsm629732a91.9.2024.08.13.22.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 22:32:14 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:02:03 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v8 01/17] arm64: PCI: Migrate ACPI related functions to
 pci-acpi.c
Message-ID: <ZrxBU4cPA6QAaxIs@sunil-laptop>
References: <20240812005929.113499-2-sunilvl@ventanamicro.com>
 <20240812180912.GA286962@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812180912.GA286962@bhelgaas>

On Mon, Aug 12, 2024 at 01:09:12PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 12, 2024 at 06:29:13AM +0530, Sunil V L wrote:
> > The functions defined in arm64 for ACPI support are required
> > for RISC-V also. To avoid duplication, move these functions
> > to common location.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Acked-by: Will Deacon <will@kernel.org>
> > Tested-by: BjÃ¶rn TÃ¶pel <bjorn@rivosinc.com>
> 
> Looks like "Björn Töpel" got corrupted somewhere along the line.
>
Thanks for noticing it, Bjorn!. Not sure how it happened. Sorry about
that. Let me wait for Rafael's inputs. I hope maintainers can edit it.
Otherwise, I can update and send another revision if required.

Thanks!
Sunil

