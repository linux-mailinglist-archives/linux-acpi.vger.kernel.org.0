Return-Path: <linux-acpi+bounces-15544-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE9AB1C3E1
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Aug 2025 11:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7FA7AD38E
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Aug 2025 09:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658F128A1CE;
	Wed,  6 Aug 2025 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpLxhWyW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4796257AD3
	for <linux-acpi@vger.kernel.org>; Wed,  6 Aug 2025 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474223; cv=none; b=X9m6jhFJ8yqUPkyBZJPyp+VQM4foOpxdxiLzYlTBcTOo9UJr3/7PNtPSDjwPiiRl8H8UY7bRmrvpVqRq5Zbgtqb8vx217mEQyOX/AHL8qFHagCDhRSQvEn2Q8b5dcZhPZ4JyUi5hDtCjB/VEHyvBQN1PUcrEE7QCNQIp7o9YjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474223; c=relaxed/simple;
	bh=UnRhCBGz/g5M0sDRDevsbQoDZqubHqeSfzdgXcUdUSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F34jTshX5FV7Lr6B8qsWJlUuKr5qzXoLFRAOOKgwn3qRDDvLuP792DBF7yCwR8Z6vojy2XXRA4GlUUC9rFhK9wImcLKl+s1ZP4EeTTrVmtUgfhyEBR6bG25Sy9ojvzBUL6QqV7AKsHzj3E3irSviX9jn7DqRTb2v0Dal7xzafW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpLxhWyW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754474221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnRhCBGz/g5M0sDRDevsbQoDZqubHqeSfzdgXcUdUSU=;
	b=DpLxhWyWvKk6KSvW39PraU/8DUTauEI+aUC96gGUFbfQjThLUBe3cAwqK6RhEA9aBhNcSO
	M5EPqLphNPDDHu8oePlpvPytak4L/JUdCfwzq124L2JX8H1ILfvELoZ5i7cydfVxsFIZne
	PugJrFLsDNC8+FkktlsccIoTcI+TguA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-OKFRjpZjPUSR3AmvMwh8ZQ-1; Wed, 06 Aug 2025 05:56:59 -0400
X-MC-Unique: OKFRjpZjPUSR3AmvMwh8ZQ-1
X-Mimecast-MFC-AGG-ID: OKFRjpZjPUSR3AmvMwh8ZQ_1754474218
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b7961b3c82so2959706f8f.0
        for <linux-acpi@vger.kernel.org>; Wed, 06 Aug 2025 02:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754474218; x=1755079018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnRhCBGz/g5M0sDRDevsbQoDZqubHqeSfzdgXcUdUSU=;
        b=aNvN2PtDr/Dx+3Orm/E8CfGHE/WkTnRCQCK0o3BloWQpSd2D7qyeoUU/iUgJyPAdyi
         /5Zhc95cOgIWJdjrVdMkr7zGdplvhUvAQDPSQr2GmZykuhi6AfyJ3z68ib0+FGqEWDdV
         OiezWTpSJqT8D8WD+lBLuF3D2DOcNHi6kgxuCYqsWJd6JkuVJLr73J2i7lWWANoVGUDI
         YFaHT2fzatphbTMc+thjfGU/AGfwUGNaoFpy1q5ECEvJMNBEvrwaFgqJX1zkxwBl4LsL
         ltUkGX5cdaPNlIremuC5FHo1dgikmJxmt4CKw/ZEEYnO4wFATZ6441T5oPYg0fOBU0+F
         tKbg==
X-Forwarded-Encrypted: i=1; AJvYcCWr5c6Btfwm8ZwbN5EHbC4+sYSIscvpaLxcz1h0QJ4yxlaZXNJDCC9VW/TV/s6J4C97KMISD9Wm66HQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxlD+0iWSvvdZhmhJcVy3xwH8cCQ0BCY2wjyTkMMPn9AYiJIkOy
	USbSfuFhE/yaOoAikyU1qFEMg7BhDnWGNvH3KRZzJozQnj4XCrhK/uelYILBYzFFTnwBM9D8b4T
	WT9kj8NwkCBNf5IPH7TCP+iiTpK/Iw6GzXOAWCmrbBiY8JjQqcixLlI7nYDeh5dmbGlrXBFiANK
	QHU0OFIz1eZduLb29b7jt3A+I0mq5ctB986pd6JQ==
X-Gm-Gg: ASbGncvMjeFptcrCjMajkZu+iQyQGM4/nIqn5kPqzni6kQdkfDNryqPVmrESQCSlV77
	bJ8IJFej90W/5KJVbFyd51C5N8ie9yuu/E+L/VXdVEPR3914cLilDuf47NOEOBd+pP2z/BwbInh
	4yBgNYneue6o8QeFKbU7u6XQ==
X-Received: by 2002:a5d:5849:0:b0:3b7:92ec:68ec with SMTP id ffacd0b85a97d-3b8f41bb8c4mr1730019f8f.14.1754474218385;
        Wed, 06 Aug 2025 02:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmkIlZiBIO0pxwuhv5ZEuhlp3NbgCJIQMCznSJgwMIdEJJHMlTE317CHbrVdWmT1WXyuHGPX1pWe6egu5BZuE=
X-Received: by 2002:a5d:5849:0:b0:3b7:92ec:68ec with SMTP id
 ffacd0b85a97d-3b8f41bb8c4mr1729994f8f.14.1754474217980; Wed, 06 Aug 2025
 02:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACTEcX6oXBot1VBApOyKVMVXsAN9BsvQMLa8J0iKpNeB-eLttQ@mail.gmail.com>
 <642d439ea1be8e48ee5c47fd3921a786452fb931@intel.com> <CACTEcX5Y3PNXNkhnK1dGFe+k3sigOZNpj66KKGAS9XeHqRu35w@mail.gmail.com>
 <0b15e33603a46f6cc7ad7d09a156044f11367169@intel.com> <CACTEcX47bUd2tp=LYkQnhK29Js=vLN0JfXL8Aq6mOFBVYumpzQ@mail.gmail.com>
 <CABgObfZKKeqMrAUyS8CB4ARkW_8Z9QREgpgYcq2jxoQ9ppS6MA@mail.gmail.com>
 <CACTEcX7oa+Shj=uYiRMoWpng+RZXDeQrOa-VTRmzVVtXJMCgLQ@mail.gmail.com> <CACTEcX7hsRkzYEBg4pQd5s36p_ZXJM=dtxSGmBjfkt5sWrXP8g@mail.gmail.com>
In-Reply-To: <CACTEcX7hsRkzYEBg4pQd5s36p_ZXJM=dtxSGmBjfkt5sWrXP8g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 6 Aug 2025 11:56:45 +0200
X-Gm-Features: Ac12FXxUD7IfHIB3LF4bE0A3e_MF7VVLU9X5HEvxDOG2SUB9XsZW8ohxIfMVMqA
Message-ID: <CABgObfZagg8_w100tEnbU0_adUWPcnQYzxy8aAyUqVASjxWujQ@mail.gmail.com>
Subject: Re: [REGRESSION] tty lockup and WWAN loss after hibernate/suspend in
 6.8+ on ThinkPad X1 Carbon Gen 10
To: Andy Mindful <andy.mindful@gmail.com>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	rafael@kernel.org, ville.syrjala@linux.intel.com, tglx@linutronix.de, 
	Christian Brauner <brauner@kernel.org>, Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 10:40=E2=80=AFAM Andy Mindful <andy.mindful@gmail.co=
m> wrote:
>
> Hello,
>
> Can somebody advise how to properly bisect issues in linux-stable
> repository between v6.7.11 to v6.8-rc1 tags?

If you can test 6.7 and bisect between 6.7 and 6.8-rc1 that would be
the easiest.

Paolo


