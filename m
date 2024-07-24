Return-Path: <linux-acpi+bounces-7042-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE1F93AC4D
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jul 2024 07:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DBC3B218AF
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jul 2024 05:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F863D97A;
	Wed, 24 Jul 2024 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0lvuDYi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF01BF38
	for <linux-acpi@vger.kernel.org>; Wed, 24 Jul 2024 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721799742; cv=none; b=YAFcHUT7mkEo9CnNQf/L5Vu+yyaByKyUuX6n0cbXY+bWtth8NbSHruVycKbp4pq8zLigRM2gaej4fUifsLEdxfgtOr9G6puj8gRMFiAfd/jJFH5Qlkb3OOKmYjgod94yBnRbLPZGY4diCxeKVHuMBEq2ZH2Yed5mS16+i7/nBpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721799742; c=relaxed/simple;
	bh=gBPQ1aOuvgEUMj1CusQ8+6eBvIC/9xBQaB2J45TjO1U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gFZDsyheuWbHsAHcOyHMEi5h2UGLP4x3FAGSI0rgs3TNBfaSbe0PdKMijrLBhhbjKh0C/QwUbZt7eH672BJKkUcwj3pMDn07GlZEUA+Q8ZIQb8X+83qoHGVtf9WpPi62VrEsizMGUeA27gHqOaG0jnkOitpfqnjL17wUqj0rB+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0lvuDYi; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso32432741fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jul 2024 22:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721799739; x=1722404539; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gBPQ1aOuvgEUMj1CusQ8+6eBvIC/9xBQaB2J45TjO1U=;
        b=Z0lvuDYigBkTvQ1F3AKtDfzE2cIJvyL2jDWBJSbMAlxm8I1agUzbOv10jcg2f/WOLi
         0al08eJVAnW862rnd/LWjPF1draRTsn+pm37mFa4rBaZZolVfZ8mRgN0d6tNs0UQooVx
         glmQH251u6+0SskhgRyc6uhK81I1W1GmmTt4pPMzru4KhUH+SH+13rXxxR/s5AIuEm/n
         Y9P5tZrLgtzdaILZt2klrWiNqoZ5A7wW2VnBJdt9QcUdLgXRDOm73sOrUGgfXm6h0JMy
         lDvGVJQ+cw7VyIrhra5z3/JuaWIhmrfK0P6KnYUxZmVuwciHRwFA5qI16rlXceB3DdT+
         +37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721799739; x=1722404539;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBPQ1aOuvgEUMj1CusQ8+6eBvIC/9xBQaB2J45TjO1U=;
        b=SYhBkepjjTYKRaRNwvRQVQtLd6noQjFJ27lCEzW0GDdPuBWNXomElDgkQ8QBPTtFTk
         hKmGOsAGMkcRdCFTFKjkfhIXhV/WeisutiwQCDFUKZ67s5kWUvxLOIcBm1IGGaz+jl9P
         RG5cDesGDAkUVnkDmuAh7LnW0fq6r3Sa1ViZ6hUwu+12ThDVLM/QNKodQFi3XOyyiZ81
         eu67QHWEidaVIbc470RiQTaYy6y09tMSJacDVNdMyIKc5QWV7lQHIg4lOBmb8KMYNaU4
         PoPn9KO+/bpKh9dQ8F4PN2FoYB+QSnh0EuzI9IwsNBvWi0uXzZ7DoYVOItOnchNwYHsJ
         nW9Q==
X-Gm-Message-State: AOJu0Yx+MmaL7Yap7yD/3OkmPFcbDoboJEp7VzYVQGZe4ee1o2pSKCfk
	Apjh1ThNcyemUdpWtaYpi0awMj7rV86fZUWA+aIHvPU+XQpMKhcrn8rvhHHC4oz4EPtsrAy+bhE
	6t7133o3M1Fgtv2ftNyRx6ce0hRYAh/NW
X-Google-Smtp-Source: AGHT+IGE7yArrmb2uyC3Ymad5eX+83ljNB2Hr6o2nFDxAjKLsHSzOQ5Ndkpn3kfbiUhWyjbGWbnX9nQ7qPdhKfVxMdg=
X-Received: by 2002:a2e:8505:0:b0:2ef:2d58:ec24 with SMTP id
 38308e7fff4ca-2ef2d58f07bmr57354931fa.17.1721799738589; Tue, 23 Jul 2024
 22:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tom Yan <tom.ty89@gmail.com>
Date: Wed, 24 Jul 2024 13:42:07 +0800
Message-ID: <CAGnHSE=RyPK++UG0-wAtVKgeJxe0uzFYgLxm+RUOKKoQquW=Ow@mail.gmail.com>
Subject: [Bug][Regression] non-stop ACPI ([\_SB.PC00.LPCB.HEC.TSR1]) and
 thermal zone error
To: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Up til 6.9.10, I would see these errors every boot *twice*:

ACPI BIOS Error (bug): Could not resolve symbol
[\_SB.PC00.LPCB.HEC.TSR1], AE_NOT_FOUND (20230628/psargs-330)
ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.SEN1._TMP due to
previous error (AE_NOT_FOUND) (20230628/psparse-529)

(they do get occasionally repeated again)

and these *once*:

thermal thermal_zone2: failed to read out thermal zone (-5)
thermal thermal_zone7: failed to read out thermal zone (-61)

But since the distro I use (Arch) has moved on to 6.10, these are
spammed *non-stop*:

ACPI BIOS Error (bug): Could not resolve symbol
[\_SB.PC00.LPCB.HEC.TSR1], AE_NOT_FOUND (20240322/psargs-330)
ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.SEN1._TMP due to
previous error (AE_NOT_FOUND) (20240322/psparse-529)
thermal thermal_zone1: failed to read out thermal zone (-5)

in the frequency of *three to four times per second*.

For the record, this is now consecutively repeated 5 times every boot as well:

thermal thermal_zone7: failed to read out thermal zone (-61)

But at least this one would stop.

