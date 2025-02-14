Return-Path: <linux-acpi+bounces-11198-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 132DBA36615
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 20:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11E917A42F6
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 19:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782E719924D;
	Fri, 14 Feb 2025 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6+CeSNs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707A15FA7B;
	Fri, 14 Feb 2025 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561239; cv=none; b=ZTJsEYZ0Df8JSW+W723R9y8+z34Y7S686rfGA2bNkuAdf13U+bfHpikYmST3giubmIVGHnpK5trCB56jiXT7k5BrrwxNaRaoUANMFFWWxz14z3l/pyaTzu+YZ0nb3dVg8EbOhz3Rg4AruNf8S5c5sHi+OxMxmEBuzym9aCj+BaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561239; c=relaxed/simple;
	bh=p7/0d+l5V8RV4soqX93cKS2oL1LZexvsGXDUFmWrnyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMGFmUe+IBki9TXv8c54VTDiBCSyB3880PaYAd6fyb1MrbRQXfAffgwpizvUuo0BvfCEbS6lEDsIUhZC/grVIz+VEKJp59Mx+pKNpgtbVlLmAxy9ycqluXqOpWxpuUKr1OsN8z1gpDxvJhsAioDV8ufwFKM2W0r0HReWCngvM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6+CeSNs; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c665ef4cso36803965ad.3;
        Fri, 14 Feb 2025 11:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739561237; x=1740166037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUg0mQM2CMJkUN+o1N0q16vh0nwicfYFgXBMHojigYk=;
        b=a6+CeSNsDMqsxHm+J/zrQ5T9DaOjri1VM0cbVIFPpLkzpCTg4cItunAtFeOdK5UkIV
         QAZ0ZRFyD2U3uZy/7nhcu9Y0C8VTYi9uAqIFOVs0F0z9shD4nCR+TFVmyae4ddRtc/KJ
         GgaYMTij+C7dvGypBc+mXDwwrEVDbiWv1ZZeja+Y4IyZwyrtT4+xrSVK+wJMVE+ICt4q
         Vl0L7l3KJv7/Jg1BCQgp/xQ0+vQNFCwXknhR7P2RvAuYLDmAOCawhvjui7lJbfBtq747
         HFMoFSJVKum4efcxKolbqW9aqanjky5r+LcVuBg2JaggQLXSXDzQ9Rtx2d68FhfnurzO
         tszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739561237; x=1740166037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUg0mQM2CMJkUN+o1N0q16vh0nwicfYFgXBMHojigYk=;
        b=vQEBi0hCvkPJbXUN/XWx2ERhpxLcgwLszXxfC0yajrY7CdhuCRdKp/KyCmJt5bLfzK
         44Zsyw8NL5sdwFNVldPLTaDmgGth9kSuuR7NIk4/kpB99GFQN3pP6fSoM9NX3lh9CfP6
         f+Az+5v4vThBT99Yy0/lfSZBNRE6DhZ+EROfbvghoACJ6oC7MySy2hjwSEFNFV/RpRSQ
         8hvTIJZ6UgpkdKd2M+LgJmonYZ6+YEw63IlGHf0csUU21aO66ZECzs9B8lU+tS4oAGh6
         nw60PYH+GafTZMtnNCvLmsWzXn5GjbeFxIczziqQCLonWUwSPZpy4HhTn9+t2q7/wbQK
         7VFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdf3n5lXZeESdwnUVE+kfexVMp0Chf+5gNP7rn62DFGtn9gk48kpPQDObZGGrR/xQC4GffearmxpFs+GBO@vger.kernel.org, AJvYcCXuRYZknaNapTIRJ7xmus2MKVnMbPPFT0XcI9kNfFKQMyfknTXTc7rWEz3x4Lmb0nITrk0nJBRN6mwu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Xm8lYvvGJ19wSVkgZPl/R7LbrvnijsfL95qlFyukoq4EQWE7
	ck4sBI6r+uHi4W77wwAkiZiI6vh7Gw4bOxdTtVkZOSjw5/Y7Qmz1
X-Gm-Gg: ASbGncs4usBNghSHki1r2M1B9v+OW3vUxSRpL8LuUNcj4q+1UDJ3SRgvUHl70/A542M
	n3GgDUhQ8pc4eucmmjAufmqlv25WArEzFWmd8Ck5+jsaPmk6j3bPfaOoTXpl3OkHAr1yWNgqJbG
	aYiajoUMvRSOuES4LjL5AtDhyHTxxkAXu52aoCVc1KKSdbmiE5r2NV3cNQGCnJhIvZYCp1T74ZH
	pqk429QQTYR+t5E0pC14YScuX7p/BgtCdRa+ELsqp8/YT4c+fOl54X7NUSKTYy6g/zSpq+4VwHD
	srLnryDutw3B/D8bdw==
X-Google-Smtp-Source: AGHT+IEQITKHY+JxPZPA738G0pbyxeKKG4JPoDIzakhJ+ccjkfc3pa3bwtzbTg5WhkTnpdCrLOJ0IA==
X-Received: by 2002:a17:902:ef49:b0:215:a028:4ed with SMTP id d9443c01a7336-22104025674mr6669385ad.20.1739561237166;
        Fri, 14 Feb 2025 11:27:17 -0800 (PST)
Received: from gmail.com ([103.210.134.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55960ecsm32264835ad.253.2025.02.14.11.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 11:27:16 -0800 (PST)
Date: Sat, 15 Feb 2025 00:57:10 +0530
From: Brahmajit <brahmajit.xyz@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, rafael.j.wysocki@intel.com, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ACPI: Fix building with GCC 15
Message-ID: <b225jidr34zzrrih4iwh6jhwxiy6fcqyrzkgakgs37odba7jhx@j5wgn2rt53ky>
References: <20250121214219.1455896-1-brahmajit.xyz@gmail.com>
 <CAMj1kXGvgad183WbUHPGduXHEahfoWasued-LdJ+Tkhc=z-9GA@mail.gmail.com>
 <20250213200605.6e62302a@pumpkin>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213200605.6e62302a@pumpkin>

GCC bug
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178,
and patch
https://gcc.gnu.org/pipermail/gcc-patches/2024-December/671714.html

-- 
Regards,
listout

