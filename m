Return-Path: <linux-acpi+bounces-12708-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA94BA7B071
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 23:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0D017A074
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 21:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC301FF1DF;
	Thu,  3 Apr 2025 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFv6r25F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170F1FF1CA;
	Thu,  3 Apr 2025 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743712615; cv=none; b=dDBDyxhhH7yZphSMYtBWMba/3MltyyUbeNGcke8PUatuWUtxDiDal7Ru8QooHGJ4mpHhSg2lehqaoaTqbc8ylDfBnUo6EWMtAhjRWeloEU9Konk1LCHyR/sK3SMCtKX2eXK5cVf21EP/OQecFRsulALq6gtpu0cd/EiJgmxWzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743712615; c=relaxed/simple;
	bh=BppNu7Me1+y1qANtVpWRom0H5KnptNr4MLRjpUZuDi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqtTzTXDPO8RrVc6tqsWd7ln+eKiZxswpwf9L/14yTIjn8gW8Ce+vN8OEP+4GqjucrAFiYYPqE8qqhq/T6keZ47cv64Wfkvecn1MhN61bgWQ25vT9EuDMb5VSEI3MEE3u6H+oVb+Xd9D35RfCnRA2dLKKk7p45FLUKTShRrZkz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFv6r25F; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so214892a91.0;
        Thu, 03 Apr 2025 13:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743712613; x=1744317413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BppNu7Me1+y1qANtVpWRom0H5KnptNr4MLRjpUZuDi8=;
        b=MFv6r25FHaUwyWCtC/6j2qLmcOx4ne1j+sKhvLOb+3jBdZ6+CguxVaPV8z8UPHdBdq
         YeP3Hsh/h5+9Oo8O65NGRBiIql0a6aYPtqSNO3cWz21LTvQMXxwWmaaMgyJYKP1MXWYf
         OKj3tWIiqZ2d2v3+EtVrrpr4vy5m88WNrDH26bmCeF5gdg9vQ+a8ue8drCHOeGZlZTxO
         LyizUvSZ1SOq6dvKRSs2ALAuL0nwp7wmzCFwBzUKMfxdLDRnAnX9cIgerMKVe+x/l27A
         5IUWc676TANDKw890OeHmDVoXQxCCg2+EqNQblhy3GOeKznbUi6MdNnJDhDgHHkYQwzl
         TcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743712613; x=1744317413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BppNu7Me1+y1qANtVpWRom0H5KnptNr4MLRjpUZuDi8=;
        b=lJyCe9BaSyT+2kaYmzKHg+79YcEmASb44vv3sWito/DcjWQQhGXhy76EFRF+eL9/Dz
         YksGnGiHJ3IIOJxB6H9vv9SVAWk3KWI+SboKuZXrjU8pc9OI6flrg1TqVVOJLWyCtB+/
         jBL5WH2FPnSwTYo/SJGOf0eVw9w60uRRBSOgLjL8x8c01jdrYd2Z8jGpKiBTbndOaZoJ
         SurOlQ4f+pnT144wxozfYtYCFUChYfFKJLD69qcCevMyHPvPu4Z4ri5tEl6JNIvTfKNU
         ychb1t3JRNEkQgs66OiXqr74UFLGAmkaEgV18uWBMhQXH2gFCLdthuGJVb6yC0P2QQnZ
         jAcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMZm2yTHqfeYRD41diNVRVCXycpF6vX8ytnGpczBmNNxbm/3jQT0qs2sjpaw9VLJAKMzaM46pgxGc+2A==@vger.kernel.org, AJvYcCW5LoQIVh+bVf4KKmDMrzsnzEMvpz2TuRVVYzCX/I3RhZ1V1hmiIY6TzVp4wTTnDW6luqFJGdp1yd2HFfLC@vger.kernel.org, AJvYcCWkmG0DyMgS7eebdscRcjhcZT0h+bdlxVjDkOSrtME2onaYJ0ItXLXdG2FKQqpsbxd3aTNqJYsMmsCg@vger.kernel.org, AJvYcCXs0MuY2pa/qj6ia8CtKTv9jNqfxLwS+mCDGiRNnW8BeKJuzFqDSkDl9F9MC9Bkh7Mkr4Y0kVIjOqpg5mv0kow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNn7qB1Eh4XS8n7EVGhW1B+XP2ecQ5vIkAgGo7cb5s1QWSPIV0
	aExEKkPGFvIRyuBvquGHrBDXle/lRDcfNiEZwaPC2uvBnGVJt6DPlQbtKmHhLce4MY6EPaLfYxR
	0y83sHW4tpFMdivr2L51CP5HUI3o=
X-Gm-Gg: ASbGncv6+ZwNiTxY7YDh/btcyBpwtG+eoPNvr4mXgxXS8GXdB31zgq57cvMlBXOa1ER
	yuatkZhLo/hNIzYf0zfyLr3CLTtYTm6Z3dOw6NNxoDsYOd/burZOQ1EOMPH0toLPd8R/8bai+la
	bXWmOADk1ohKoU4cFZTkCeHfjtkA==
X-Google-Smtp-Source: AGHT+IFUqqbzGb4SQKutumz1ZzcvzJ1fzw2t9YPUt4FlFYvaChfi94wViOQAF2zeZ+yWVNNsiYR6kCFprhocxgUNro4=
X-Received: by 2002:a17:90b:224e:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-306a477443bmr499789a91.0.1743712613272; Thu, 03 Apr 2025
 13:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326171411.590681-1-remo@buenzli.dev> <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com> <CAL_Jsq+tJvGsbw1dGdgmBM8+cL4vN71OMTvX9tkmBLNk=6T9KQ@mail.gmail.com>
 <Z-60LwRrw30cq4YE@smile.fi.intel.com> <CAL_JsqKiYCh7ukDoqc_toyn75=3wOM4WyOTGvogoOfdz9T_7Ow@mail.gmail.com>
 <Z-7LcXoGw7uNWBUE@smile.fi.intel.com> <CAL_JsqLCa8AjwsUpS-N9FWymG67w7DjmmBZCKW7G7BAfY78vWw@mail.gmail.com>
In-Reply-To: <CAL_JsqLCa8AjwsUpS-N9FWymG67w7DjmmBZCKW7G7BAfY78vWw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Apr 2025 22:36:40 +0200
X-Gm-Features: ATxdqUFQzyzFDIUd15N-qaG4eeA0ujxuGg9ZAeaFdtFtoYw8fth86HH_5Xp9cUo
Message-ID: <CANiq72=iD5ogB2Qjn=WNbghouuER5ypND9=Y_wFiTDfPC2NgFA@mail.gmail.com>
Subject: Re: [PATCH 03/10] device property: Add fwnode_property_read_int_array()
To: Rob Herring <robh@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Remo Senekowitsch <remo@buenzli.dev>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dirk Behme <dirk.behme@de.bosch.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 8:48=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> Looks there are RUST_BINDGEN or __BINDGEN__ define which could be used
> here. Don't need a header, just wrap the declaration. No idea which
> one would be preferred as there's exactly 1 use of each. Miguel?

If you mean bcachefs' `RUST_BINDGEN`, then I think that one comes from
bcachefs-tools, i.e. we don't define it.

Cheers,
Miguel

