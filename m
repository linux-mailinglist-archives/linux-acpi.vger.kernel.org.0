Return-Path: <linux-acpi+bounces-10069-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF17B9EBDDE
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 23:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532FF283432
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 22:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB862451FC;
	Tue, 10 Dec 2024 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f/wv/ihL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660312451DF
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869932; cv=none; b=tKDgArW55AaSBOQOEnOCialIRz9H2UKHAMVkeO8fIzcuE+2pL3V2rbeGA8c3phqggTpGYuL8JysAPn3XYo3fTbnSTQBkf1nbOGgH4rtbyZ7rmgIpFW7d/qN9UWftuW237Ak0OX8Hkrs8An8gkG08dDpohS6jYu4gOaMusHwEmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869932; c=relaxed/simple;
	bh=5sAckLh2O+Xqp/B3w/FFV+cbSlpNec1FrjP1mHYiP74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgpD2a+AOUuX9sM9Jrc4I/fGXO9h7fbSYxenMgAk1sURWsh9/Hq06pPNbnME2dLf+IiqXx6v6+9qT2akPz2j6PbN1Ko4PDqE++kwPEL3tf7cWO4hZdhUtU5ZManIpfy9+qikiQLFLDRcsUUcLBwVBNdhYEnob2vO8lZ5eG7Carg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f/wv/ihL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728e3826211so909167b3a.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 14:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733869930; x=1734474730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbiia8j7j6jNdjJNl2DYQMz55vjkekkDfU83OLWkpH8=;
        b=f/wv/ihLvW2/2ov8v20nmbmpK2J8ZIBGtAM7ggkCAXloTlmJPDNi6Y4LXqUOigxMBn
         QvqdnzUrN9duPio3kzsG2XlK5ACOJFfRgX/n8ULCmTSS+am8O6peZW7P2ZgwAoNJ0SR9
         QKIFNOXLj773muXuEYPl5f7vYs/82+zH+MfhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733869930; x=1734474730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bbiia8j7j6jNdjJNl2DYQMz55vjkekkDfU83OLWkpH8=;
        b=CVdKReft4WCQMu0jzBExgCDA5pm7HCiFawEZGoYsmPcEJUbqD1Hga+4MFaIcGsJxMj
         KVUrv/hKdxajywal5MWuRamBY13VdRejGafOUvAWssM6SQrCRFfMrPz0Brsc5uCMt1P3
         KtH8VMna7IWXH/WIlmHEakYdC41lz2zeyQEW/GdIIMyBrj49xBTptLCilW/iAgzIMsA5
         SwLLpMHYeSrqGVbXRATV2JF8lnH7B3uXmw0vhm6W3Um0iXTqaNKjp7vOdeWkGzluVsUf
         p9yezcc48hbUdWs+4dUahI5CVdgCBWy838TwA26dzuXZd/xM3sZ1oKyGpwd6emdnKG4C
         JWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHMD5AX38ShFuV2Rd4mn4eoNn0Glv535Lt0r2pTS+XX99gI5t4Be6qSLmKP5ittgvpKRvSolwNUoJF@vger.kernel.org
X-Gm-Message-State: AOJu0YwqV552fcH7n/8UuNhUZUOmOjNLl3Vly2/wjeFQn98uIlEMHd1j
	T9RqeNOnhBPGK9vtVmDKgV8wK3p7lYOtbSbAMPhn5WjOgbKEuq/dID3o1k/BpZsjmHZbLxez1sk
	=
X-Gm-Gg: ASbGncuRsW3QvN56mK+mBkidrIygzEzvFTaxgvWzTDuGVRd+zfEk+qebO7Jon31aYKv
	gyRXZALuy01juknUK/D94GvvWlpQeggoiC0TXta95FcMLu8918O+fmgtaPFOjpnWIXjGJoxlrRa
	PMg1smoHX1mZthhqTEsIUkTnskYIPfxSv/a8qoVqViovwLSCK5J2dQ3z+EVjtxk/M/oEz6kSs/U
	X4DJi8+HEkt1ujZ3Jc3OHvi+lHQHAy87ifaCMUq8JCSgLTMtmrPECmnrvJ6wZZowAfMPWhJuixk
	FOFklZethbhwYRp1
X-Google-Smtp-Source: AGHT+IH7S+AMdcqeC1oKiFNwUhzREV2E26u2c2FuduATINg6Jn6DH6ooPY7ak61kVLjOMb/vTlVbbw==
X-Received: by 2002:a05:6a00:14d2:b0:728:ecab:51e3 with SMTP id d2e1a72fcca58-728ed3ed738mr1005550b3a.11.1733869930430;
        Tue, 10 Dec 2024 14:32:10 -0800 (PST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com. [209.85.216.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ddead564sm5897837b3a.107.2024.12.10.14.32.09
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 14:32:09 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee51c5f000so4414350a91.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 14:32:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8ads/+2q9gpeaiMsdsrybzGGh9vefOE6MV/3EgtqDjawJ4C5BkUm27oNDcAvhGK+wYeBPMDXaQ/p5@vger.kernel.org
X-Received: by 2002:a17:90b:4b12:b0:2ee:c797:e27f with SMTP id
 98e67ed59e1d1-2f12804fc63mr899384a91.36.1733869929209; Tue, 10 Dec 2024
 14:32:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-4-00e409c84a6c@chromium.org> <Z1irAT0KVwqhBSSZ@kekkonen.localdomain>
In-Reply-To: <Z1irAT0KVwqhBSSZ@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 23:31:57 +0100
X-Gmail-Original-Message-ID: <CANiDSCsLOODLhGrpPwOQ1j+coSb9yHYi=wjGpZ+F7VbA7AM0og@mail.gmail.com>
X-Gm-Features: AZHOrDm5Mc-6e5PYz70Xt3CVLGWF-rWtXL2uCKjRJio5ykJKaQ08kVB9D3kD-OE
Message-ID: <CANiDSCsLOODLhGrpPwOQ1j+coSb9yHYi=wjGpZ+F7VbA7AM0og@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] ACPI: header: implement acpi_device_handle when !ACPI
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 21:56, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Dec 10, 2024 at 07:56:01PM +0000, Ricardo Ribalda wrote:
> > Provide an implementation of acpi_device_handle that can be used when
> > CONFIG_ACPI is not set.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  include/linux/acpi.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 05f39fbfa485..59a5d110ff54 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -787,6 +787,12 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
> >  #define acpi_dev_hid_uid_match(adev, hid2, uid2)     (adev && false)
> >
> >  struct fwnode_handle;
> > +struct acpi_device;
> > +
> > +static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
> > +{
> > +     return NULL;
> > +}
> >
> >  static inline bool acpi_dev_found(const char *hid)
> >  {
> >
>
> Please remove the extra forward declaration of struct acpi_device a few
> lines below this.

Instead I have moved the function under the forward declaration. Let
me know if you disagree.

>
> With that,
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda

