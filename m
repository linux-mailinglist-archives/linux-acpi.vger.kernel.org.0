Return-Path: <linux-acpi+bounces-15517-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB6AB1A542
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77BA1887110
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5372C20A5F3;
	Mon,  4 Aug 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVVSzHLQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0D1FECC3
	for <linux-acpi@vger.kernel.org>; Mon,  4 Aug 2025 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319048; cv=none; b=YeJM6sEOI0oUlDVAq2HpmLlwVeI0RSWXvGZrTTg39iLykRDzj6AscDMVfCyw/QjaYHh8z1y4yT8ec0yo3PqCoumLK4iyJZ5imxCU8roVtav0kw8/FAqQRvI3Pv6H1F4OB5XDfFEXTRs5kbKgHrEZyPnhoelTQ+qhaDP5ZkGBDes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319048; c=relaxed/simple;
	bh=Th/zbNG2w/sGAVRFlv12HJ6Li/jSTJBgQ6X2ZZll/S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XogCxNR4TozfHlSLOhrpBefQAmU7BBqd47sLYcTgZtoVouj/K0U5bOCfryGHiC+OIQC2dH/J4+Af207mQHsh5TLvzWsoin6I6I56VtbmVMpx12w0asv88Aio9YgPE2WsjFgxJoUdE9dH4IzdTayQsCecYTK1IiHD/xecKvi/eQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVVSzHLQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754319045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Th/zbNG2w/sGAVRFlv12HJ6Li/jSTJBgQ6X2ZZll/S0=;
	b=aVVSzHLQw6fg84JfSkKhF2q1tlPIzjPZ4WLZPDtx2ACWheNLR9vBglTpdxkL/J7LgvMgSu
	ua1ih3+SvfyUKSqDJH7CV8074qKkobCHP+sAJb7x+EtDNv5NneZ1vFXA+XoqkP7NDtQHac
	HnFeD0Gt8InYnuZjXh4s83vilNjLSUM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-U_daTIcDNMORZP8WOtOevw-1; Mon, 04 Aug 2025 10:50:43 -0400
X-MC-Unique: U_daTIcDNMORZP8WOtOevw-1
X-Mimecast-MFC-AGG-ID: U_daTIcDNMORZP8WOtOevw_1754319042
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b788d00e26so2366712f8f.1
        for <linux-acpi@vger.kernel.org>; Mon, 04 Aug 2025 07:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754319042; x=1754923842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Th/zbNG2w/sGAVRFlv12HJ6Li/jSTJBgQ6X2ZZll/S0=;
        b=iIEpDBd/Lr4JtTOzT9sD60qREZq+kmSOl0fgztkky1Eb5lXiiRg8JJCDzSPMlPhzgT
         gJloURacxE2XlAKWbWBBc+1TBN6+ywT7CvPEYEXiZnYUoxvSoTKtfi4fEMtStWEWSLOa
         zbdF+hH151lNTcyyr1uBTUipuQfmHTJuH1qZ1EJOJ3S/FYHX+jmIXk5VerDl72yC0Oiq
         TEgqk6PVfHCm+l9LmWEJsKAronGUice7UzMNt77EemyV0UCh24UWF02VZhkIftHdBpfB
         A9KEE6qj1kh2oeC37V0OC+Sw08HB0u0VC5DPHK9a8ru1yt54/ImJRQtiiyD1zoXDTwrE
         L7Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXnhc9lPmDwXtlvyTVYXasOixgDen5IRQSVHcalmvjE5XIXhkS2Tgu7ygsoinLiZqTX0xCaZOn4luA9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4nTWfFDMGw/COqoyHGDf1A/7tVA7O+4uXJ8fBbjJruKG1rzHU
	RMVru86DjuZ6uZSXvjoDreCEIClhfmTD67HeUO5+UD7R2qfMY76RZ5fY6MfGMJe7yS5vX5y1Pt+
	tfr78aS2+TeTz8ovD47vw4fdU8gm6cKqivPMttWEChgU4tGBPodwi0++hf9J6tgpMQHN6UFv9OY
	otIiOCCfOcRL4X88t4rTHlKLdhaik+Hk7KCTw8HQ==
X-Gm-Gg: ASbGncuV5H5wUM/87vOHxd7vK7b5xDu1yWQ6HooSnBbV+zS60JZvz8B1ZjwD+qB/Mtz
	0drFu3L9aFM6lIVavMVK1QExVnQTte9S/b8yG4o3B7wIXPTnUCFwJURR7UeEhzSZVUNDhQboXI+
	BMKoUnx4h2Xdpryu0qgxx+
X-Received: by 2002:a05:6000:1788:b0:3b7:94c3:2786 with SMTP id ffacd0b85a97d-3b8d94c1c49mr6701547f8f.34.1754319041928;
        Mon, 04 Aug 2025 07:50:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgsw4pwEJUoqykoSclSWi0JkSR9VtvKkMXz/zduARm+hjzykjvBGRpvCt0a+Ds377veRWW/i7OVVOUhVwFvkM=
X-Received: by 2002:a05:6000:1788:b0:3b7:94c3:2786 with SMTP id
 ffacd0b85a97d-3b8d94c1c49mr6701520f8f.34.1754319041488; Mon, 04 Aug 2025
 07:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACTEcX6oXBot1VBApOyKVMVXsAN9BsvQMLa8J0iKpNeB-eLttQ@mail.gmail.com>
 <642d439ea1be8e48ee5c47fd3921a786452fb931@intel.com> <CACTEcX5Y3PNXNkhnK1dGFe+k3sigOZNpj66KKGAS9XeHqRu35w@mail.gmail.com>
 <0b15e33603a46f6cc7ad7d09a156044f11367169@intel.com> <CACTEcX47bUd2tp=LYkQnhK29Js=vLN0JfXL8Aq6mOFBVYumpzQ@mail.gmail.com>
In-Reply-To: <CACTEcX47bUd2tp=LYkQnhK29Js=vLN0JfXL8Aq6mOFBVYumpzQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 4 Aug 2025 16:50:28 +0200
X-Gm-Features: Ac12FXwltMgUzEEB8nqMLRA_D51YfOsfFkH1rt4nc_9cVgH_FR6V2EdEIAFZooc
Message-ID: <CABgObfZKKeqMrAUyS8CB4ARkW_8Z9QREgpgYcq2jxoQ9ppS6MA@mail.gmail.com>
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

On Mon, Aug 4, 2025 at 12:57=E2=80=AFPM Andy Mindful <andy.mindful@gmail.co=
m> wrote:
> Double-checked bisect, looks like I've have found broken commit:
>
> > > git bisect bad
> > > The merge base ba5afb9a84df2e6b26a1b6389b98849cd16ea757 is bad.
> > > This means the bug has been fixed between
> > > ba5afb9a84df2e6b26a1b6389b98849cd16ea757 and
> > > [1b1934dbbdcf9aa2d507932ff488cec47999cf3f
> > > 61da593f4458f25c59f65cfd9ba1bda570db5db7
> > > 6fc5460ed8dd0edf29e7c5cfb1ef9b1aa04208a1
> > > ba5afb9a84df2e6b26a1b6389b98849cd16ea757].

This skip is messing up the results:

# skip: [0dd3ee31125508cd67f7e7172247f05b7fd1753a] Linux 6.7
git bisect skip 0dd3ee31125508cd67f7e7172247f05b7fd1753a

and there are still 3858 commits in
ba5afb9a84df2e6b26a1b6389b98849cd16ea757..{1b1934dbbdcf9aa2d507932ff488cec4=
7999cf3f,61da593f4458f25c59f65cfd9ba1bda570db5db7,ba5afb9a84df2e6b26a1b6389=
b98849cd16ea757}

Any chance you can get 6.7 to work and restrict the range further?

Thanks,

Paolo


