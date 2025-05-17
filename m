Return-Path: <linux-acpi+bounces-13772-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7825ABABEC
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 20:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5CF18823B0
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08A319E96A;
	Sat, 17 May 2025 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SphmvRfh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCBC201013
	for <linux-acpi@vger.kernel.org>; Sat, 17 May 2025 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747507900; cv=none; b=B+llWPgo9Qce3rtfoftJWlUgZ+3mS5ib8boG/ym4SKeNaEPqq9XwyVSvuVPF5NxX8SWfbqwXYkZIuJMqq4wrLpVysNbilb9HhDVfxf4OxFpJURum7eCX7rYobI+R83StSPXGXC85qw/KW0v0AZ75fhm6+gOYNXFKRcLpxcQVlnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747507900; c=relaxed/simple;
	bh=esvr8R6WEoSrZXgQlzfaTrT/BDn5P1ZhexoSJKjzt7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHY49l/LK493Jm8hx2AY8iq2qN03FVacqqHF92qVx+EV3LuNsEC3vBwbBVffufEOuXPxiKPW/b8YtOFgjd0687BWXYS1I7NCAJ7NrU6Mxbfoxat1b+HfJ52S0vxpCZsRCAisIuJFyEHBkIrfBVSbT9+Km2MmUeoLjarL/II467Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SphmvRfh; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ad564b7aea9so502466b.1
        for <linux-acpi@vger.kernel.org>; Sat, 17 May 2025 11:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747507897; x=1748112697; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=esvr8R6WEoSrZXgQlzfaTrT/BDn5P1ZhexoSJKjzt7M=;
        b=SphmvRfhzRyPcBCXHlc3FF9CBrmzQ3pC68oIkqHkVFl5/20Gsju4RGg+RMbmgmSkP9
         9N8BQv59YtEKHh5DTP6YnNvuKeWu0i5NseZsdwp3jv8f2vNOltc3sJ2QD2Inrfsv7f4z
         hWtExXCJZVEu24y+5ciLy6UhXvF7J3t/m8VnSE/lqxLoa/GrjQKletZwoE7qYbFknu/1
         KgwWVHWZcMAGie/0MyPYhVQBmoh9IwqwH/Cg6BdHQENqYo8PoHFbbwJY70ZnzURr/UFS
         TTx1XO81a29fRPv+JDNb1lkm9ZcV3RK665J7At+JeBDvpnSth/QQndrI6Mq1blsP+2f4
         CLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747507897; x=1748112697;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=esvr8R6WEoSrZXgQlzfaTrT/BDn5P1ZhexoSJKjzt7M=;
        b=wambY6/B3qE534RbChRlY845y9abX8nKGNk+X7mucxrPF+r/pg9etMN7TLUbCFDtKn
         fjzIp1DKHMpUgew2cSJBnU/XCofFl0/lRXgrc2W1rZbLjijZe62ZS3JEZfdaiQW8DuJh
         hcv2DZwPekiK3JKAHqG9gCw5GIacffetNxp/X1UvFRe/j62fOImQ9bgvTW5vib4UqkMH
         febjxuJ89Y4Q3R03OZmsX0AGlSpDWSdmqkud49Vc/brFIJYoYp4xYWaPziR8mQnnVsC1
         jjIeYIsIeAtWxquk0LEZDWo5+LSzDfC9N+y280+gZauU53f4l6/r8szA0+1Q+FUgIHH4
         NOCw==
X-Forwarded-Encrypted: i=1; AJvYcCVTVEjqqQKQZlmkBId30KgXrNZCII82JMhzAQd6FxFrWmsm3PBMxiULrgi6klc5MZBDbZuNO9LjZitH@vger.kernel.org
X-Gm-Message-State: AOJu0YzYejCRuBdU8wJqOnXAhYpGnzzgFrOaAQhbWLhwbofq5nPqe27R
	QQ6sM22fF/6vqtvufPvWVknbnEwoMotHwapd/N679DtezI8gBc7VMyOgDHBM6D3rreA=
X-Gm-Gg: ASbGnctNukzgQOM7Vocn2ke/VK8psoQpwRazDDUE5gYrb/aKl/sRxU78z3iB2mxLNN9
	of6mbmKtgkoWyK6xg1mMXMP5PJ0Dws5L/7MBu0B9nCp2LzL47xsWA+c5hBBcAGkFIvTVOnaShmq
	LVc9TbWWOECfz2cS8YTqJ5bWo3j2zZC5baP0npEDk+iJ5J86AFeKcxT5cJINIWfND6izZeF6c2r
	rwEcBd5cmG4KqGMAtMko8ipMcfIRI2hZ9bzY3iGhnpr/Zg9thlMkTg3tgh70bxcRhIXc01EjWVd
	325/+NLkoIGI1HQ4gvd+nCcDoV5Q7WcmuWZsBKyGyvod2kMpjhofmcqzDzFf/KBLXR2XGiq3lrC
	rUBbKzihzqRruN3E+p3lhXBugdgLeIcUruBLQQ0NB24s+ZXc4Gt1RPVy+jfxU5IjTf/roOehN7n
	zEJfChjVXFx3w=
X-Google-Smtp-Source: AGHT+IFEF2Q0UxOZnJlm+Ccp+4eTz4P200IBb4VqMusjriDU43pbgoKygbxgSW1mEWMO0YQml7o1iw==
X-Received: by 2002:a17:907:7e9c:b0:ad5:11a2:f95e with SMTP id a640c23a62f3a-ad52f1a09b1mr739087266b.5.1747507896600;
        Sat, 17 May 2025 11:51:36 -0700 (PDT)
Received: from ?IPV6:2003:e5:872a:8800:5c7b:1ac1:4fa0:423b? (p200300e5872a88005c7b1ac14fa0423b.dip0.t-ipconnect.de. [2003:e5:872a:8800:5c7b:1ac1:4fa0:423b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d498747sm329295866b.137.2025.05.17.11.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 11:51:36 -0700 (PDT)
Message-ID: <5f76fa30-53cf-4cdd-9201-5fd525573858@suse.com>
Date: Sat, 17 May 2025 20:51:34 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1A 2/3] x86/xen/msr: Fix uninitialized symbol 'err'
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org
Cc: tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, boris.ostrovsky@oracle.com, dan.carpenter@linaro.org,
 rafael@kernel.org, lenb@kernel.org
References: <ae1d05f6-cd65-4ca4-87c5-af0ae34e21ce@suse.com>
 <20250517165713.935384-1-xin@zytor.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20250517165713.935384-1-xin@zytor.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wYlEYju0WXW3nEzZsQVz5sqK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wYlEYju0WXW3nEzZsQVz5sqK
Content-Type: multipart/mixed; boundary="------------npkniPAj3lZU17c0YJiIJgOs";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org
Cc: tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, boris.ostrovsky@oracle.com, dan.carpenter@linaro.org,
 rafael@kernel.org, lenb@kernel.org
Message-ID: <5f76fa30-53cf-4cdd-9201-5fd525573858@suse.com>
Subject: Re: [PATCH v1A 2/3] x86/xen/msr: Fix uninitialized symbol 'err'
References: <ae1d05f6-cd65-4ca4-87c5-af0ae34e21ce@suse.com>
 <20250517165713.935384-1-xin@zytor.com>
In-Reply-To: <20250517165713.935384-1-xin@zytor.com>

--------------npkniPAj3lZU17c0YJiIJgOs
Content-Type: multipart/mixed; boundary="------------llwv3cxcMOeLkriHHzdPWzyR"

--------------llwv3cxcMOeLkriHHzdPWzyR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDUuMjUgMTg6NTcsIFhpbiBMaSAoSW50ZWwpIHdyb3RlOg0KPiB4ZW5fcmVhZF9t
c3Jfc2FmZSgpIGN1cnJlbnRseSBwYXNzZXMgYW4gdW5pbml0aWFsaXplZCBhcmd1bWVudCBl
cnIgdG8NCj4geGVuX2RvX3JlYWRfbXNyKCkuICBCdXQgYXMgeGVuX2RvX3JlYWRfbXNyKCkg
bWF5IG5vdCBzZXQgdGhlIGFyZ3VtZW50LA0KPiB4ZW5fcmVhZF9tc3Jfc2FmZSgpIGNvdWxk
IHJldHVybiBlcnIgd2l0aCBhbiB1bnByZWRpY3RhYmxlIHZhbHVlLg0KPiANCj4gVG8gZW5z
dXJlIGNvcnJlY3RuZXNzLCBpbml0aWFsaXplIGVyciB0byAwIChyZXByZXNlbnRpbmcgc3Vj
Y2VzcykNCj4gaW4geGVuX3JlYWRfbXNyX3NhZmUoKS4NCj4gDQo+IERvIHRoZSBzYW1lIGlu
IHhlbl9yZWFkX21zcigpLCBldmVuIGVyciBpcyBub3QgdXNlZCBhZnRlciBiZWluZyBwYXNz
ZWQNCj4gdG8geGVuX2RvX3JlYWRfbXNyKCkuDQo+IA0KPiBGaXhlczogZDgxNWRhODRmZGQw
ICgieDg2L21zcjogQ2hhbmdlIHRoZSBmdW5jdGlvbiB0eXBlIG9mIG5hdGl2ZV9yZWFkX21z
cl9zYWZlKCkiDQo+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVy
QGxpbmFyby5vcmc+DQo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcveGVuLWRl
dmVsL2FCeE5JX1EwLU1odEJTWkdAc3RhbmxleS5tb3VudGFpbi8NCj4gU2lnbmVkLW9mZi1i
eTogWGluIExpIChJbnRlbCkgPHhpbkB6eXRvci5jb20+DQoNClJldmlld2VkLWJ5OiBKdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K
--------------llwv3cxcMOeLkriHHzdPWzyR
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------llwv3cxcMOeLkriHHzdPWzyR--

--------------npkniPAj3lZU17c0YJiIJgOs--

--------------wYlEYju0WXW3nEzZsQVz5sqK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmgo2rYFAwAAAAAACgkQsN6d1ii/Ey/y
1gf+OIrTmR24006WFmEsHRhFAD+Rxh+DPGsuFdt+zPIvZT46MPLR0SQ9a4Xugs+lkkjnEnwBQ4Gp
sCkPjxXliS8bO+w203UixwqIvyYXSTVMhdl0kvgEBcDobMfbPQExTR0iGja6kQyiy/Oyhz1/MmWe
sKSteetLIxXWLruF/qFh0yxi8QLgDs8vkNY5eTA9Vzx0iGItISRn3u5v/qpmW1Cz9+sSEeihfULy
t6Q9miXwajrovQR3tn4+NBKOaF4oRnM74lrohRFAJRHj46vmMRqkO8n1WkLV5c6KsjSyh4102Mh3
J0gYZzleGWsaA7/Q2Xb8VT4ECuTX+pTYeMtzNV74hA==
=t71+
-----END PGP SIGNATURE-----

--------------wYlEYju0WXW3nEzZsQVz5sqK--

