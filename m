Return-Path: <linux-acpi+bounces-4909-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03DE8A23B3
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Apr 2024 04:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7145C1F21BD5
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Apr 2024 02:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B35BD2EE;
	Fri, 12 Apr 2024 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fTiPib+h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C49134B6
	for <linux-acpi@vger.kernel.org>; Fri, 12 Apr 2024 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887818; cv=none; b=pz6q8ENKTvefW3VifB38kX2aROF0GZ/e57BKXN+EckbP5m9H8q5+lcGWbJsKylyp9vZPAFvTht8tH78+0qsy0T0SXwvcBRNpZYRLv/QB55t/IyWuzrpC0JVtq8hbSfrbkaTbZiKQEtvk0EYpM33Yl8l2KqUqTSl7HctBX+eF8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887818; c=relaxed/simple;
	bh=3byBbhHPbAbBuHjuvastDaMYVcOaFYFEWRQWWcNBJEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPKo7dBg+54fxVC4XlqojZryAnTDuX5u8xuXfvpdkEeBTM9xQ4vb7jd6tkdof7eQoy/v6h8y1NJCv1V99G9KxA+VTdcPGloT8dNOs0nITHUQ20rL7rLkzlUavmeb2WK0y5YdqBCcRgx3p2y3nIBfsjTIUngRTUJekVUrVNyCSYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fTiPib+h; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-222a9eae9a7so269650fac.3
        for <linux-acpi@vger.kernel.org>; Thu, 11 Apr 2024 19:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712887816; x=1713492616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3byBbhHPbAbBuHjuvastDaMYVcOaFYFEWRQWWcNBJEs=;
        b=fTiPib+hPpELBGl9mXBDX3GtzxsphGVGmZplXY5c60TQ5YwaTHjWIPUD9Zi66Kt3lB
         7EUU6013wMnUxFPPrW14B06w77hD8EclgIpmhhdPUFbFq32MG0W7fp0UTv1TP8pMs1iA
         vb8DJdVtoewMod9+w90f6OOs/OJahX6agucWrnZ/bMsXr4LhMjMJspjzVuj7pYR1fs4/
         6FTPaCuCYb42sDTDgcb2BeYqrp7RHm51wSJw3jrWf9RjQLxhcr8w/3YslbRXAyCN1pLU
         gYyms8lzPhWTT5LlOsBWolG/RWKZ2lR1I0ksEX+HvtmJnFhlKIL+HfNBDUPYt376pHvl
         3SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712887816; x=1713492616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3byBbhHPbAbBuHjuvastDaMYVcOaFYFEWRQWWcNBJEs=;
        b=dml8F1jn4G6hLRui/tGOPLpzG328MZ4w9Ks7bsoGLrAuIN9+Tax9Gn32qAoDZZh4fp
         w1Kuf/hvltG3mdV65KV5ROcmSRa0A60/582Cbvl/iga+CyiKJBynnHDoty89lJZsCEhc
         7WqIOHCElJwKnF2AzhEFaTTZMkXi/4qjzcV1jnxFXbFaNMtmLo+QOEd7KXhP3rrCjhHs
         ik/TI2F1zTKjY0b9csPgv49avvDdiVpnhPCBkna0lgy/UY+6OjXbdFN91a9OcDzkTNyz
         4IWhdKfV6gMhTwxX7/07KVxzruLTdNNRNgcp7UAFvGdXD8spsBHZTt3/DZKNHPDVELNt
         iZ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEa2SvePiZa7Oy16apjblqgBB3bO8MCfqm3L+NjGf7h0kyhmnSwc4CT9fZUUaFDQUZHSzYO4EW8zKH/NGBd+2JA3G1xeu5UxSXqA==
X-Gm-Message-State: AOJu0YyX9cqZtAFHk91zb9khD6PIv8oqsw14f+acqCu0fwPCnJLHOs4B
	IdgRnPTyzIonboveT1Qvg7WJkV7fdnCqIUBOnShj0I+4F1Ui9FZKPKQA+ITCXjslSr+ixvCbIVx
	yJ2gHmNMFmMX9iVeOeHkY3RXeHIYz0zSfg9uhbw==
X-Google-Smtp-Source: AGHT+IGlOlFyLP7nb72631wmeBnbeNqFrUTNa6xuGgqZC1KLH6e9hMuOyTmu/5EQbYJDgq3GFRyDSHVjJyECJ38qxLI=
X-Received: by 2002:a05:6870:390c:b0:233:4685:aea3 with SMTP id
 b12-20020a056870390c00b002334685aea3mr1355286oap.41.1712887816077; Thu, 11
 Apr 2024 19:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407123829.36474-1-cuiyunhui@bytedance.com> <ZhetojJewygmTf6N@bogus>
In-Reply-To: <ZhetojJewygmTf6N@bogus>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 12 Apr 2024 10:10:05 +0800
Message-ID: <CAEEQ3wkfHvH4jXNO5NRDf0Fc3xUkY64hp7BDBmgNVdcsmYy-kA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo
 entirely with PPTT
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

On Thu, Apr 11, 2024 at 5:30=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Sun, Apr 07, 2024 at 08:38:28PM +0800, Yunhui Cui wrote:
> > When the type and level information of this_leaf cannot be obtained
> > from arch, cacheinfo is completely filled in with the content of PPTT.
> >
>
> Which platform is this ? Is this arm64 based or something else like RISC-=
V
> based ? That would help to understand some context here.
>

Thanks for your response, RISC-V currently has this requirement.
Please see: https://patchwork.kernel.org/project/linux-riscv/patch/20240407=
123829.36474-2-cuiyunhui@bytedance.com/

Thanks,
Yunhui

