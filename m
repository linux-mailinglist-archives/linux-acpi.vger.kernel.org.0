Return-Path: <linux-acpi+bounces-15516-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55937B1A40F
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 16:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106F33A0365
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 14:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810E126E146;
	Mon,  4 Aug 2025 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mbW4S+UY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1051FF1AD;
	Mon,  4 Aug 2025 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316404; cv=none; b=OzdroKkSOyO34iRz6IH0EjS2jB2epAC29JBrSUA4H6cOHS+TpRzmWtll561NUsIAIeWcQ8rU7s7YqcbnEdxR2Sl1MvdyEK3vmluPmExfKOvxhCUNSM8rbUM7pNf2zW5gnuqBYckyXVDRaOgYQBUdpI6RZDFEcdrW2S2pE/jlqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316404; c=relaxed/simple;
	bh=24P3ex0rlJ3RqZJL9JxHuPi3XZQr76oFtlGvBq+NWpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIeOJamPy7V4KjLBQoTmtaPJHEt63PF3R0u/T/FPLqaCaSl6PSQJ6CSlor4hlO1BEUbxqSgWldr+PoMYXCi7e8GITm+bRDTZy+W6hNWbXnYdxjs30heHPOVNh9eOVQHD77hOtvizQNPNusGLBbDBh7g4VikBlIbOJ1ABqv6M+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mbW4S+UY; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754316388; x=1754921188; i=markus.elfring@web.de;
	bh=89+LSE4n1Nea1RoBnD5H2ZBhlSpidKRnCq5+0UpQHL0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mbW4S+UYGWhP7oj5v4fPWEJnfGDhx9danPyRhp3Ov31fi+DVmIItPDSAU3qifu6q
	 XFL6mthWX/wpvgaHxtdk2TRFx5jJbNprIptZhxokxeO2ObG62doeNcD2Fh9R6f8fu
	 pnzsyQwUpIRiRSp+foP8YoplT0wHD7qBwbp7397FyyhKs7UGfKJ0Zh+tycUZeO9mh
	 Ty5spTTSnDCO1K1KCe5Z+Di6ljd0WftUpYUVNKiSWdnN5woRBqfXE615CnQv8ADlI
	 gc5hIudKG13b4055tsc3LyDYevvEFDneoEQuvETqFUL926Z5OkRBXE6K6u8EiON+1
	 /4i7RJx7zQF8lr4zaw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumJF-1uS5XL19yV-010sEW; Mon, 04
 Aug 2025 16:06:28 +0200
Message-ID: <94f2cba6-a407-4a0f-bc66-be75b4dea190@web.de>
Date: Mon, 4 Aug 2025 16:06:26 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mailbox: pcc: Add missed acpi_put_table() to fix
 memory leak
To: Zhen Ni <zhen.ni@easystack.cn>, linux-acpi@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>
References: <20250804074115.44573-1-zhen.ni@easystack.cn>
 <20250804121453.75525-1-zhen.ni@easystack.cn>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250804121453.75525-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fR4ggwEXWjZQnOoklEq+X1pMJCb8kVzv1HfvLxXhzf8wqS9VS2L
 mEwtoT9Oyl2RYPx3L5Sg8o/PS53Mn3E9ivJaOPpS43VLoZQGgFr6iLVKPej/buKIhXtKy9r
 oKpdL5h67jZuoWQxdNSbvlUl65nniWtlAO6kHBDMhQP/YW3cjEWjZxzstwY6KjPUpboCGLo
 13qUfwEg/EB7MrjnKo72w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q6qOsZNyH10=;NMV9S4VjBf/9es+yf08t7dhBsWI
 UZ1hC372bOCMfc8H2/COg+A1rqpMBqGtA/n9gkPdpXWHRKEAYxHPsIbnNMMYGlTC9K1htT9L3
 18jqfW50DU+FAsgGjbpf4ewZjCUe0eKxisdsweP7ys74VB7ORVVNDheyRN/sEFF3vTFiqeTTK
 +B11ksqbTn1F+wEd8j9Zj5NBqDnXAcyHOoEcmglJ7oHl9BDwSgC6bbbsYmwyi+s+nqOjuFaBl
 hkFcMZ1UV6rI46L5bImZ4s4O5JufLTTaXoFpoz2zjXv9MBm5UYKrrsIwrWRwEmBkK04IQbgQH
 Ty3gtkZdfjAmObM1Oum6p+phTZIeg452qCosibCdTek3QllMa44TRSX9CKavxzRI1+e2i15X0
 3g3scjQQABMf6nZc1c5hXLrzTjUhtnknK1Wr6VeSmlIYYWN5Bs1IhXmnsdU40uuavOxH5L8jg
 bE2qNXoZIOJ0Eq6Nzw9VBP1jWNWAJ3mex0Zjao40cJdE81860fHBIA6it7WsZyREMGhYysL3X
 eGI74rSQhX0zrO3526iziUPoNvExZumPwxvUvWfJmSBXmS/f0NF0ygo+btZTLYTgzgk6U9eeq
 MqcAp/dFt/mGbel1HEBoeP95fdCGXKKnp+uQEvV5LfBHj+se57vgKCqu+MdR9JerEF07kTRB5
 m5gGopNTDT2maPCWSsOhkeVY1yH3X9oE9WyIpzHvG1I/uSKEnfWnTz09XDyZdnsOIXAiiDK8m
 kyW5P+axWr7KZCotG2rm1LdLy12stvhRGxn5mmdba9vAeDS21sV91gYDfcx/o32xR9inSaVzK
 CWE3z+wi5jCXXgMKixixNMlSZWvEMbUaylBufKgZBLaKeaJX2kxvgZg1A76U9LWszzwxRweJq
 IvLZCOqEDmiIBNpZ5dLtUi7VtQSKoJrZ4zF4YIkBP0ibojuX5z/RrjvoI+ITyzmZT+TmHqNIh
 aamtGlRj2FeulqzRhlReBum/m6J7X88NVZjgQz9j/Q6ZdzGeTORYV0PzvzwwKh8AyXkoHM/Fg
 syDn5VtKor5bLF3MjyAR3zPlBxCtjLzuoGMFOB3rfuc+PwkiPW7ct0NE9EBoJ1UuD9+8xnvq1
 0Slr/5j57r7Byc4AGHEPkhBYpDlEbVqDzKySr22f4cwDc5dEGyaq5XEboM5klIRVtT72MGd2Y
 dTtrGCyMxz/vPhetV9UWRIZXdS+iKlzUcvFC/a8dapciN9Jr6UQdku24So1f3lb/cpcJ5xvDB
 1rbM0gP+W9hsumj2jp2wbtgYxegeqHMKIX5nlqhewXRcGGB2n8wihbEKnoujS6v9qfh1ro+o9
 oQZl6ZSuADwrEvnpffUjHDZNIEWmBZX6H0+LeuU3qubSLZxeICvcX+tA17FroaJWAKB42DJ4U
 R36TS5uH6cMyvjfXJWhYUPwYnxHqfO7gEMtfJNOacs6pezw41ko8YIcwKqVc6s+Jf5uNU7nSZ
 0dFAHWpBA6TapFV+tVNAsfJoQRiOLq4so08QDv2UtTQKAQjw6RpVDeiLSidFzuqgXn68twSm6
 a24uP2iHLRHwoZ5+hYWTElL/i+RHka4lVQSNuPndHOjV8IqEjyi6gxtxL1IOBjeujA6IzyGMk
 0Vaf+T2i4apWL3OmYBttC75QDClH9p0p0Gw0oJ2TnNeMIZdWJH7ALbUF6ADcINDcV2leKtUba
 Hm6OC/jnNWMbsGf3lk1UHRPexgDT+V9XdeYfNU/b+ZYfkd8VrdzPNdyn0s6PvzMYhLghu+BR3
 /TDccS2M9DDofsIvqoKYadM6JU5I7Wp5B2BnPJAv04djYRYxNhCp/hTYJyofeNdJh99P6J6G7
 hL9jo0guua0EHX1VMppkTdJX1nOarejNzgaJGdW2+NZD4Ris7lcS1mYRehOHovCbHPh9RUj0H
 6xypFYHBiItopgjaMtcykyOj1pFLlSF7uf4HMSdH19yjU06taoUq6OF0gZefJnVgRESis8WXN
 p8ddRWIDRt9LARPoz7BvkK7gcwh28r+y95eWGg02gNgtBXjOCnc0MYhqZImMdaVuJcD+IX3zH
 eyoeualXa1GBumGVK/K/57/seUuTlE6JXHOYwidwIRSudO8LBwa/x0lLoqsMQ0be+wo7j42Sr
 TRd01jfaurylNYn11g5IXPa9PGsLwhWJVphcHJ5jRtjXm+b9XkDIHOPxfp6qgLwQ5W8gaXBqH
 aiOuLayxmXU4QSCvq6PTcHjeezFUVJM/GPTRYTkkV1wxLZF7AIwQryC29tYhwkTZAWYxwTPvn
 Pf8YbM9hNJmUolbbpt9Q31cwDw9Y2pKisv7R1D9wRhydYBa7XbxJFExxF9BI3SGx38Wajyene
 aXeLZa/GkY/JTGTKnyBQqJX9/2Tv6AH94lgiFELAEJ35QNSm+ymfP3YM2Kyo8vHrfhttukxls
 SZcyWyhpZBGsve4glZ3LH+ZEKdT4VN0nu6U/6pVNeqM0r3Hc7UFNp69ThZXSmN2oqeJvj9av1
 Gvb06wUsZDTRHmFluc82r+HGZmWlXITe2HBRwcc6AZ5DzObc9C+c6O9bc7roGuxQox+/vP7u3
 Ijuqhc8egJT9jxVzXVMy1n4z46XEiPsMCoCV/jRwf9YHn7M2XJLbiHXyZw16DI0jiu6+qt1WB
 1axq74dRr9qaWmQNlMrb5NONTvXYZpFkWRerOS854R17EVVQXGgdlSBp9mvuhBRYObOWiE4Xw
 jM/wq6uT4H8z9IGh+FSV412bXoUopRMSzZadlWwnuBTj1dmjkL4d73Sg4EhcuqXtGSCt8Ayta
 RPL3OuShbqHUOk0lPhFz9QNbcDRtHZp0hUiZusI7XIqOc0NVVyiFCxOay5Ku1oNrCM/f/wBUf
 nmG4vQqW+FI57l/pRwjZ/BnqZTkb2PLZ6sGG5Eht8+TMXUU5zyNVhMYzNSTUypiqXl1lVTsxQ
 yoTZ+oLMHvpBCon2Re8vDoPbBt42LGgkudABM4uI7lRjoiRN+jjAPdIYmMbOwZLKdPnjyg6YA
 SaBBEzCDWik1230TRD0ZRrESZmYAvtjWFoGhg0yIbRZ7wSfnZxb5noIrxssyikGxp02wHnnpu
 JHBf36BS0iYeMd0+fa/YJftUScMGxHev24rpT6UpxGRfW3ho6SmDIS6eRTBzyW4rmL6maFT25
 TFU6kM4L/bt4jP+EPZw1ZJcovrXBlIyoSexP+aYPnad3v1Jbzip+avmGqOAe2yL2AFdbp09Qp
 HWFEwkilHKt1tongOR/JG6pU2UQTIKamUR2TLLGW0O+oH0xcU4mtTTF2VzmdIAYr7QKfrpMgi
 bl2o+Xcf1l6+/W/sgat5oUAyNrw1nT5lZBC6pSbk4XoX0R+dB3lKKde5wZScQKMTrLaJ1Zpq9
 cHri2o8N+ndA7cV9KkNWpSn6wTE+3hhBT/jglN2nIpuSgGgX1zhqDxiQAFPjqLqxx9pNwcDlk
 gzPmWsElIncgK++GF49hILUMSS1MZvH08uOYcx0yynPheC0U2crfVKWdE6IQwJfwNbo87lx6w
 1+NEsopvHrSQDEAn43aZgo3hv1q1iKGYOi+R77yRU4aHnBZ9iLK9C

> In pcc_mbox_probe(), the PCCT table acquired via acpi_get_table() is
> only released in error paths but not in the success path. Fix a
> permanent ACPI memory leak when the driver successfully initializes. Add
> the goto label 'err_nomem'.

You may use an enumeration for your change description.

* Fix =E2=80=A6

* Add =E2=80=A6 so that a bit of exception handling can be refined.


=E2=80=A6> +++ b/drivers/mailbox/pcc.c
=E2=80=A6> @@ -827,8 +821,11 @@ static int pcc_mbox_probe(struct platform_=
device *pdev)
=E2=80=A6> +err_nomem:
> +	rc =3D -ENOMEM;
> +	goto err;

Please omit such a redundant statement at this proposed place.


>  err:
>  	acpi_put_table(pcct_tbl);
>  	return rc;
Would a label like =E2=80=9Cput_table=E2=80=9D become helpful here?

Regards,
Markus

