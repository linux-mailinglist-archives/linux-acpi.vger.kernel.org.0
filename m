Return-Path: <linux-acpi+bounces-12460-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C30A7205B
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE5D1897516
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F1B253337;
	Wed, 26 Mar 2025 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGH83QG7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19F49659;
	Wed, 26 Mar 2025 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023069; cv=none; b=VGiY9pV6HhVoc4/zY18zDdTGlhsH1MIrRGLMHdUuJ1CiYwGwInEj52jCUrCSCR7CUNIewYpBuBNhpJaoCd0d/OVYkZARN8oVP/SeA1QFrxiCOvx/UI7HRLZnc3yw3LnR2qM816Z+ANBeg6m9JHf5BvHLD9h8ne5Csql9H8xKgf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023069; c=relaxed/simple;
	bh=TArcQTxrgr1eb9R+JMG9nSrSsD2zBBgzcm7kkL2AbpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSs6m6OnXEew/o9Xpb2KF5QrqgaHTX6cYQbTTjKCyE8yg9iz96TmkTv/vjS5DXsm88QnJkkckC2sPMq7EQAmxP7pSzA7jnQZ/pfsX4XVlQhZ1/NwXfPJmzYC93vJPScuPrSzD+nUkVj+f65hSIWqMZKrjPtrB+fwdGJdOzd0LkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGH83QG7; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3fefbbc7dd4so81388b6e.2;
        Wed, 26 Mar 2025 14:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743023067; x=1743627867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozVPTnoMLma4OglcHu3vIpr2scI7Wzqzcsqtqzz0t8g=;
        b=aGH83QG7Id/cTKa5PfhlseoZ6n0b7h0n53v5vQNa14pCkahNVn+h7N288TmGwWrUls
         6vVXSd+CT56mAOfJHTqmfVvBPakniWTyJMRlRbSQBo62pqzKCX5Q0KoWKClfpN5RDLWp
         Zp28VOxFCErXeydB8jK9dKhs429fecrYi8m98fAsP4+xn3WDsLrJRonva/DLLMJsUYxe
         5zJt/LccXbS0n6as2NBrGjTuWnZ1I2sYk4l42sZj1CLTMQsXDUyNX5wdl1lgE54K3tWT
         A11RW9oqMpI4REj91lSekuA3ua8ZubB/eZvPd1xQoXs+02hkE7gud4DjWvzW8UgvKYWh
         Nzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743023067; x=1743627867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozVPTnoMLma4OglcHu3vIpr2scI7Wzqzcsqtqzz0t8g=;
        b=Pt3uStI13GST7XFiHQotzUM3w1O+JLWAQ7odpguM1/2PziE4k1/yqY2wkNlITERvY9
         dUV3CqJTD1vPlsELjk3MkQscF23jCWhoMkrT4Q08VBd4C5r2cAtZfqiJcY4Mj14Yhkhf
         oAusK5tZcQkjU4AD13W9XaTXpG8REOblsOWs85BErDj1b8BBVAYjE9fSIUAsF8GebP8W
         aXRMllcYsj4s+LjPMP7i886Pkudu2fh+K9NulPGMySDCGBakdHHNIVb82YP7T6/S2/XT
         e7rcoLywK40hk8QQ55gJejLCTfm7crzaVt9Ny9r6V2LRHStaZQ5caqNc6Ui7I6oDiH8B
         jhEw==
X-Forwarded-Encrypted: i=1; AJvYcCUJALTEyWbnkca4cGJ1K7Y9l6zqASUl4EQrksFoEsZ+5orKwC8/QtEgard1BbKkjC+VwHRZziNhqOR+hw==@vger.kernel.org, AJvYcCUPNyTY3GlfrXsQqCOa+3s8y+BaXBFg02AEEWB4Er5MCF+9QARfWPV6juzEhenjxInMWLI3MWUchO1RnZl5lLc=@vger.kernel.org, AJvYcCW4jz/IdunM8SpUkA18AfyLtZARs9v2HmZcAIcGUChvl/hp5GhgeknVVF76JTwWirnejqM3sE109bZD0T0k@vger.kernel.org, AJvYcCWEl3Ca2A3kzs7fRzyxZvNcuxwv/NyggIX/gtZz8VYoCB/gHPrcz2wWPc/Twc7V3RsCHyBGITBfrwUh@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBYWIv3Nj92s2Gyu71vBwPrNH/DGauG6jBcJLFCQptI8j2ih5
	smjNlaDSKgTXIe2U8kTd7zgyxtcJWAyM0eVDMMhnlwHQeYSnWr1b
X-Gm-Gg: ASbGnctLl+qike10iXK++A1isaMnh3r/ZziGg9EA+m+H895uRtucmVQ4dlkonrQHQe0
	FXYVyXQOQTPd/6+89xoujP4VUVryHAk4+9rzDliFL5c6azeZpcYgjvy6awzb0xOoDsE0D4dzI8m
	EuAVNyTqawpWRz21KPr2LDNEGfBzEwiySIR/2L45jWn4hgBpl0Q30uv16NDS8MBaiQ5A21l3AyH
	zf3Aqwwgjow+ipV+vgtWDUPihpNNG9z3dDaj8EzGU/QtRL85AjFPMFsltlN2ujD/qJ1gxfSonm1
	iJrbgJlsCGf9iv1riiH9v8ckmGiMZVe7NLjHCP3yaHDmRWTLxkaUqhp2t7f/6zupTb6uT/GD29Y
	IU4bvQqBwygFj0i+6HqWHyGtIMyc=
X-Google-Smtp-Source: AGHT+IGFpzMq1O2Poh6oWUp4yY8thHY+iW8mZHjXAEYKAsdnMpS0h9TCqF7PT/JKmZxnM7+vPN5Irg==
X-Received: by 2002:a05:6808:3186:b0:3f8:c7ce:2723 with SMTP id 5614622812f47-3fefa5ffff2mr679866b6e.25.1743023066745;
        Wed, 26 Mar 2025 14:04:26 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72c0abac389sm2500628a34.4.2025.03.26.14.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 14:04:26 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: remo@buenzli.dev
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	andriy.shevchenko@linux.intel.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	devicetree@vger.kernel.org,
	dirk.behme@de.bosch.com,
	djrscally@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	robh@kernel.org,
	rust-for-linux@vger.kernel.org,
	sakari.ailus@linux.intel.com,
	saravanak@google.com,
	tmgross@umich.edu,
	andrewjballance@gmail.com
Subject: Re: [PATCH 06/10] rust: property: Add child accessor and iterator
Date: Wed, 26 Mar 2025 16:04:00 -0500
Message-ID: <20250326210400.695960-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326171411.590681-7-remo@buenzli.dev>
References: <20250326171411.590681-7-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Mar 26, 2025 at 12:13 PM Remo Senekowitsch Wrote: 
>  impl FwNode {
> +    // SAFETY: `raw` must have its refcount incremented.
> +    unsafe fn from_raw(raw: *mut bindings::fwnode_handle) -> ARef<Self> {
> +        unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(raw.cast())) }
> +    }

this safety comment should say why it is ok to cast from a
struct fwnode_handle* to a *const FwNode

> +                    // We will pass `prev` to `fwnode_get_next_child_node`,
> +                    // which decrements its refcount, so we use
> +                    // `ARef::into_raw` to avoid decrementing the refcount
> +                    // twice.
> +                    let prev = ARef::into_raw(prev);
> +                    prev.as_ptr().cast()
> +                }
> +            };
> +            let next = unsafe { bindings::fwnode_get_next_child_node(self.as_raw(), prev_ptr) };

this is missing a safety comment

> +            if next.is_null() {
> +                return None;
> +            }

Andrew

