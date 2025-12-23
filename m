Return-Path: <linux-acpi+bounces-19833-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A974CDA246
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 18:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A881D301BEBA
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 17:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039DE33375C;
	Tue, 23 Dec 2025 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="ruYLz2ZI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC092356D9
	for <linux-acpi@vger.kernel.org>; Tue, 23 Dec 2025 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511688; cv=none; b=LGkQZhIcmsZ9pY1N6jCAwtxA5+uFK50aINQEqnXJxlJoqrYYQLJJg5HV2RXiaZjhpbxYC88Zv88Xm1Gzc3rGbRf7+BcyVep1LKrTUngvOF2KuxV7NgEfilLCVUi+cFL2OpLo1bfMdGExRHzhe9kaxlrwx9p0TQQp/gQLh8XFmIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511688; c=relaxed/simple;
	bh=4g6cRpSF90Sm8HT2nVak24i/3RDc2QDXNk1+OmWVOyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSHUiBFRbJKDUFsFmARKiPiV170FtRUPOqNMMNLkn0vGaezPuhZ78IG5LEW6iHnxFlb8fw3mg8RwcKB8SHAWqI0QvW23vlt8k0eVdjqTfpp+sYt+IHGQo44JlqZGGPYNzRpxa/H7Cgr8AgxgZgNQBB0CA07khs2In6sEXfHfMAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=ruYLz2ZI; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3ed151e8fc3so3488516fac.2
        for <linux-acpi@vger.kernel.org>; Tue, 23 Dec 2025 09:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1766511686; x=1767116486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4g6cRpSF90Sm8HT2nVak24i/3RDc2QDXNk1+OmWVOyU=;
        b=ruYLz2ZIevlheBvfv+g18A5vh8St/IDIDegOlLZrlR0TfsogTJrFZLVkZxXqRR66pr
         bet2B4WYJbZhoINe8ooHjb1N0IASQH6rlREr38ueC/wtgh/sFpmAIJqwIS5suF2kmhgr
         cJB1ejrjxImbn0v35qdyQ9s59tAnZff3d4WAMmNbuIwtGwj6dNKF7O9aTqq8HaFKa9J0
         C3easPuoFM1VS/7hXLBkcQXR+rikl4Cf1ra6shTQam6yxS3sSrXcsPXp42Nn8ZUxcEFZ
         redYlUY+3hKlAzF8gMoMVGBeAsO1g5BHhJctkzPpTEpudI3XMWGfdOcs+6cVvUxLj8vU
         4tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766511686; x=1767116486;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4g6cRpSF90Sm8HT2nVak24i/3RDc2QDXNk1+OmWVOyU=;
        b=OfVjNlsGdwtMT9K0hLA2hZGX3Ist5LU88oOJ0xuGqnQSebXq74glEqFO6UDrnQ593+
         vpkUMtYyIzCbK5OFI8rAd8uJSxCBycQIBANyPsuPzE9xsWm/HhWCNuauuh5o7ndvay8B
         mAY367XGZqf+jVZ5KJy3GpiS3y/mWsIC+YB5OfxoOcLeO7L41hfpQkA+nOH9D9doEAWj
         uTyyvXnkAZ9egv+6FcGugvUGFZLK58UZwepYbhyvF7lvBeb0rlu86xMEmQS1+f4gYNsl
         6OES5oCVnxuzzZPbb/7jH0k4m+RuZh9eDEOxTAfVawHMBfekCpd4WvmgBxbirfVXyn5K
         sRsA==
X-Forwarded-Encrypted: i=1; AJvYcCWFLe4rWypjeMwwt0qO33UYUqLKl1unMj444H3SmS5MPXT1d6R1u5eSZwZG3Jnt2kMw11bvfDONyBOe@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Sfd/Utg7P7ipB3NhuEWU4sSHiq24xMPVtDsKI9qt8y+MAtvl
	QUrIp3achOOgOu0KPEhBaqo8CQrQMF5O32fnX6yrR3nJ7HKI0qOI3KvbR3CVPB32UJ0=
X-Gm-Gg: AY/fxX7NDqIkCeSea6VsdqIUlEqAbLWdr4IYxV25qy0VPX/yUglmRSl/u3s40jVMMXH
	FLIwXdvHXVcMmv79+mbv2Kbi7yBFG/jOMjNe5cchOHIlf/K+bnkNLy8YL9QJLC+94H+8sj9xR2O
	CAC3QXzG0UAuWUBO/zvZl59TL1maUCCJM4j0aOXKALOPFgg00qIMmqHaizsAGtRm9HwsM0JfxwB
	TKHuBPQEPqitPiNeuKG9Idnld6NL612S8vNUq0Hn2XZ8JF71ruBLL7k2GDJIPstLJuPe4i2Z8dW
	pTKYbhU/iS4vq4QhenMUzv5LOp6Aetm4CGDVcgiqSOthwq5NOYHR0m12rwc9xrXempVBn+NCb48
	wvWTXS9LgoGc3HKXJlTIxuT2R4z3w7asMcp2xWTtwA9Iwn2adupjqKI5fk91EQhazVtWTjsfCUT
	XzEVfR7JA=
X-Google-Smtp-Source: AGHT+IHvO/iSXTzXMcLwk1UZ6R+sF3sMQvret+M/zf3RXcZhjvO++LdF1822NYem8TQNIc1FlzGzmw==
X-Received: by 2002:a05:6871:2b1e:b0:3e8:8b6f:9d85 with SMTP id 586e51a60fabf-3fda585f9bbmr6902517fac.29.1766511686089;
        Tue, 23 Dec 2025 09:41:26 -0800 (PST)
Received: from kf-m2g5 ([2607:fb90:bf8f:aac:a6ef:c339:5c5a:a921])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaab65749sm8780158fac.11.2025.12.23.09.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:41:25 -0800 (PST)
Date: Tue, 23 Dec 2025 11:41:22 -0600
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: kernel-team@lists.ubuntu.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, mmikowski@kfocus.org,
 rjw@rjwysocki.net
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
Message-ID: <20251223114122.0227dab8@kf-m2g5>
In-Reply-To: <250bec4336d5e7adbc841e4945e50e589b10c375.camel@linux.intel.com>
References: <20251214184507.21f95134@kf-m2g5>
	<33fc5ba96b80f1eeb69777822cfddefe64100540.camel@linux.intel.com>
	<20251215092525.6ea95739@kf-m2g5>
	<250bec4336d5e7adbc841e4945e50e589b10c375.camel@linux.intel.com>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Dec 2025 05:33:08 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Hi Aaron,
>=20
> Tested on a platform with the similar CPU (100 MHz more max). There is
> no issue in max frequency or base frequency display.

Hi Srinivas,

Thanks for taking the time to look into this. For reference, the
X560WNR-G that we last reported has the INSYDE BIOS version
1.07.07S3min29. That might be useful when reaching out to Clevo.

Since we=E2=80=99ve seen this on hardware from Clevo, TongFang, and ASUS, w=
e=E2=80=99ll
want to report to all of them. Can you tell us what tool you are using
to measure the max and base frequency displays? Are both P and E cores
displaying the proper frequencies on your end? We can then share that
with the ODMs.

Thanks again,

--
Aaron

