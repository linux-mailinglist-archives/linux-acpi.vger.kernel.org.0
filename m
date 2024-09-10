Return-Path: <linux-acpi+bounces-8207-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A61972BEB
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 10:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1A61F257F4
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 08:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF86188CBE;
	Tue, 10 Sep 2024 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fTS/563F";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fTS/563F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9817BEBF;
	Tue, 10 Sep 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956139; cv=none; b=aCrJzoai8C/muTMN9V+3hmbum6kksr1C36sk4IWcDDwHD2mFQJxRLdojqOqoz1LDw6NfQAcsE81TaImFJkCR44R6r41ljTteOuyANgVeYIzvQ3e0K/eYaCUUM7L8tKDdiLmcIrNR1c41flCwp1zIOxI1rQFVhvxv6I1VZfp65KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956139; c=relaxed/simple;
	bh=Kg35Jxhzlot8Y+GAiDtS901/Vkw+YaePavzX1TcgZrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5thi6QtxPAghjRNYHpKwiN9WAkPa5CoXKN6AAIPXkZ45r4RuY3Z0omyzXjREj0FIKtZ3QrqcF8Nil9wCDNzhai2J4NHqYy14MtiCDQxIkPQtxzP7nx545J4Xm+OeAxWcT2hw0zn5Sr2UYDLItEsa5vPmRndueKbyYFI2WjD6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fTS/563F; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fTS/563F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 383601F454;
	Tue, 10 Sep 2024 08:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725956135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Kg35Jxhzlot8Y+GAiDtS901/Vkw+YaePavzX1TcgZrY=;
	b=fTS/563F9LVbM09/01DW//DZ6qkbxFi79rCezgfQ5mGYNpBTqiTnAIn2pWYd3h2Q8wF/rU
	VYAOEC6Ihb9BuPnZswyWVNz/bXiGpl2khsGDaMyuAZ5XfkY23IIMEv5gVzzsVQeMvpVzA0
	M5kJGl9ZRyzb07DJC0ublWwI8fxbDTE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725956135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Kg35Jxhzlot8Y+GAiDtS901/Vkw+YaePavzX1TcgZrY=;
	b=fTS/563F9LVbM09/01DW//DZ6qkbxFi79rCezgfQ5mGYNpBTqiTnAIn2pWYd3h2Q8wF/rU
	VYAOEC6Ihb9BuPnZswyWVNz/bXiGpl2khsGDaMyuAZ5XfkY23IIMEv5gVzzsVQeMvpVzA0
	M5kJGl9ZRyzb07DJC0ublWwI8fxbDTE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4BDB132CB;
	Tue, 10 Sep 2024 08:15:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id He2LLiYA4GazNQAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 10 Sep 2024 08:15:34 +0000
Message-ID: <b6bb45ab-23bb-458d-a8db-9619f594e8c7@suse.com>
Date: Tue, 10 Sep 2024 10:15:34 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] xen: allow mapping ACPI data using a different
 physical address
To: Jan Beulich <jbeulich@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-acpi@vger.kernel.org
References: <20240820082012.31316-1-jgross@suse.com>
 <20240820082012.31316-7-jgross@suse.com>
 <607602c3-5199-4326-8676-d28a8b42b4b5@suse.com>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
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
In-Reply-To: <607602c3-5199-4326-8676-d28a8b42b4b5@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------X2tBXwJJQ7URBhPPEYI3057i"
X-Spam-Level: 
X-Spamd-Result: default: False [-5.19 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-0.99)[-0.991];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid]
X-Spam-Score: -5.19
X-Spam-Flag: NO

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------X2tBXwJJQ7URBhPPEYI3057i
Content-Type: multipart/mixed; boundary="------------6YVa1chSCwOeY5jwVx9Pxq9k";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-acpi@vger.kernel.org
Message-ID: <b6bb45ab-23bb-458d-a8db-9619f594e8c7@suse.com>
Subject: Re: [PATCH v2 6/7] xen: allow mapping ACPI data using a different
 physical address
References: <20240820082012.31316-1-jgross@suse.com>
 <20240820082012.31316-7-jgross@suse.com>
 <607602c3-5199-4326-8676-d28a8b42b4b5@suse.com>
In-Reply-To: <607602c3-5199-4326-8676-d28a8b42b4b5@suse.com>
Autocrypt-Gossip: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJ3BBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AAIQkQoDSui/t3IH4WIQQ+pJkfkcoLMCa4X6CgNK6L+3cgfgn7AJ9DmMd0SMJE
 ePbc7/m22D2v04iu7ACffXTdZQhNl557tJuDXZSBxDmW/tLOwU0EWTecRBAIAIK5OMKMU5R2
 Lk2bbjgX7vyQuCFFyKf9rC/4itNwhYWFSlKzVj3WJBDsoi2KvPm7AI+XB6NIkNAkshL5C0kd
 pcNd5Xo0jRR5/WE/bT7LyrJ0OJWS/qUit5eNNvsO+SxGAk28KRa1ieVLeZi9D03NL0+HIAtZ
 tecfqwgl3Y72UpLUyt+r7LQhcI/XR5IUUaD4C/chB4Vq2QkDKO7Q8+2HJOrFIjiVli4lU+Sf
 OBp64m//Y1xys++Z4ODoKh7tkh5DxiO3QBHG7bHK0CSQsJ6XUvPVYubAuy1XfSDzSeSBl//C
 v78Fclb+gi9GWidSTG/4hsEzd1fY5XwCZG/XJJY9M/sAAwUH/09Ar9W2U1Qm+DwZeP2ii3Ou
 14Z9VlVVPhcEmR/AFykL9dw/OV2O/7cdi52+l00reUu6Nd4Dl8s4f5n8b1YFzmkVVIyhwjvU
 jxtPyUgDOt6DRa+RaDlXZZmxQyWcMv2anAgYWGVszeB8Myzsw8y7xhBEVV1S+1KloCzw4V8Z
 DSJrcsZlyMDoiTb7FyqxwQnM0f6qHxWbmOOnbzJmBqpNpFuDcz/4xNsymJylm6oXiucHQBAP
 Xb/cE1YNHpuaH4SRhIxwQilCYEznWowQphNAbJtEKOmcocY7EbSt8VjXTzmYENkIfkrHRyXQ
 dUm5AoL51XZljkCqNwrADGkTvkwsWSvCSQQYEQIACQUCWTecRAIbDAAKCRCgNK6L+3cgfuef
 AJ9wlZQNQUp0KwEf8Tl37RmcxCL4bQCcC5alCSMzUBJ5DBIcR4BY+CyQFAs=

--------------6YVa1chSCwOeY5jwVx9Pxq9k
Content-Type: multipart/mixed; boundary="------------06OUwrU5hpjk2ccnTfNzqkbJ"

--------------06OUwrU5hpjk2ccnTfNzqkbJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDguMjQgMTE6NTYsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAyMC4wOC4yMDI0
IDEwOjIwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gQEAgLTgzOCw2ICs4MzksMzEgQEAg
dm9pZCBfX2luaXQgeGVuX2RvX3JlbWFwX25vbnJhbSh2b2lkKQ0KPj4gICAJcHJfaW5mbygi
UmVtYXBwZWQgJXUgbm9uLVJBTSBwYWdlKHMpXG4iLCByZW1hcHBlZCk7DQo+PiAgIH0NCj4+
ICAgDQo+PiArLyoNCj4+ICsgKiBYZW4gdmFyaWFudCBvZiBhY3BpX29zX2lvcmVtYXAoKSB0
YWtpbmcgcG90ZW50aWFsbHkgcmVtYXBwZWQgbm9uLVJBTQ0KPj4gKyAqIHJlZ2lvbnMgaW50
byBhY291bnQuDQo+PiArICogQW55IGF0dGVtcHQgdG8gbWFwIGFuIGFyZWEgY3Jvc3Npbmcg
YSByZW1hcCBib3VuZGFyeSB3aWxsIHByb2R1Y2UgYQ0KPj4gKyAqIFdBUk4oKSBzcGxhdC4N
Cj4+ICsgKi8NCj4+ICtzdGF0aWMgdm9pZCBfX2lvbWVtICp4ZW5fYWNwaV9vc19pb3JlbWFw
KGFjcGlfcGh5c2ljYWxfYWRkcmVzcyBwaHlzLA0KPj4gKwkJCQkJIGFjcGlfc2l6ZSBzaXpl
KQ0KPj4gK3sNCj4+ICsJdW5zaWduZWQgaW50IGk7DQo+PiArCXN0cnVjdCBub25yYW1fcmVt
YXAgKnJlbWFwID0geGVuX25vbnJhbV9yZW1hcDsNCj4gDQo+IGNvbnN0IChhbHNvIGluIG9u
ZSBvZiB0aGUgZnVuY3Rpb25zIGluIHBhdGNoIDUpPw0KDQpZZXMuDQoNCj4gDQo+PiArCWZv
ciAoaSA9IDA7IGkgPCBucl9ub25yYW1fcmVtYXA7IGkrKykgew0KPj4gKwkJaWYgKHBoeXMg
KyBzaXplID4gcmVtYXAtPm1hZGRyICYmDQo+PiArCQkgICAgcGh5cyA8IHJlbWFwLT5tYWRk
ciArIHJlbWFwLT5zaXplKSB7DQo+PiArCQkJV0FSTl9PTihwaHlzIDwgcmVtYXAtPm1hZGRy
IHx8DQo+PiArCQkJCXBoeXMgKyBzaXplID4gcmVtYXAtPm1hZGRyICsgcmVtYXAtPnNpemUp
Ow0KPj4gKwkJCXBoeXMgPSByZW1hcC0+cGFkZHIgKyBwaHlzIC0gcmVtYXAtPm1hZGRyOw0K
Pj4gKwkJCWJyZWFrOw0KPj4gKwkJfQ0KPj4gKwl9DQo+PiArDQo+PiArCXJldHVybiB4ODZf
YWNwaV9vc19pb3JlbWFwKHBoeXMsIHNpemUpOw0KPj4gK30NCj4gDQo+IEF0IGxlYXN0IHRo
aXMsIHBlcmhhcHMgYWxzbyB3aGF0IHBhdGNoIDUgYWRkcywgbGlrZWx5IHdhbnRzIHRvIGJl
IGxpbWl0ZWQNCj4gdG8gdGhlIFhFTl9ET00wIGNhc2U/IE9yIGVsc2UgSSB3b25kZXIgd2hl
dGhlciAuLi4NCj4gDQo+PiBAQCAtODUwLDYgKzg3NiwxMCBAQCB2b2lkIF9faW5pdCB4ZW5f
YWRkX3JlbWFwX25vbnJhbShwaHlzX2FkZHJfdCBtYWRkciwgcGh5c19hZGRyX3QgcGFkZHIs
DQo+PiAgIAkJQlVHKCk7DQo+PiAgIAl9DQo+PiAgIA0KPj4gKwkvKiBTd2l0Y2ggdG8gdGhl
IFhlbiBhY3BpX29zX2lvcmVtYXAoKSB2YXJpYW50LiAqLw0KPj4gKwlpZiAobnJfbm9ucmFt
X3JlbWFwID09IDApDQo+PiArCQlhY3BpX29zX2lvcmVtYXAgPSB4ZW5fYWNwaV9vc19pb3Jl
bWFwOw0KPiANCj4gLi4uIHRoaXMgd291bGQgYWN0dWFsbHkgYnVpbGQgd2hlbiBYRU5fRE9N
MD1uLg0KPiANCj4gSSdtIGFjdHVhbGx5IHN1cnByaXNlZCB0aGVyZSdzIG5vIERvbTAtb25s
eSBjb2RlIHNlY3Rpb24gaW4gdGhpcyBmaWxlLA0KPiB3aGVyZSB0aGUgbmV3IGNvZGUgY291
bGQgdGhlbiBzaW1wbHkgYmUgaW5zZXJ0ZWQuDQoNCkknZCByYXRoZXIgbWFrZSB0aGlzIGNv
bmRpdGlvbmFsIG9uIENPTkZJR19BQ1BJLg0KDQpEZXBlbmRpbmcgb24gaG93IFhlbiB0b29s
cyB3aWxsIGhhbmRsZSBhIFBWLWRvbWFpbiB3aXRoICJlODIwX2hvc3Q9MSIgdGhpcw0KY29k
ZSBtaWdodCBiZSBpbXBvcnRhbnQgZm9yIGRvbVVzLCB0b28uDQoNCg0KSnVlcmdlbg0K
--------------06OUwrU5hpjk2ccnTfNzqkbJ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------06OUwrU5hpjk2ccnTfNzqkbJ--

--------------6YVa1chSCwOeY5jwVx9Pxq9k--

--------------X2tBXwJJQ7URBhPPEYI3057i
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmbgACYFAwAAAAAACgkQsN6d1ii/Ey8E
KwgAgiWnIRVgRVkQccRuxTBrqf6nD2kpLeVmHtigMnPYOgTPOMZkl2EXfkmdexD/tisnDPYqMge2
hQqI4hgn3MjZzJAvJY82VYfiGfAMAfkQf0z+WgddwoRItyB/q451sSdCDyuKTIH+Ii1oBCwujhH4
FFfadMbbrfBJKzt9SxBwlyv+fEHdDwQHw+qD+crsH+VL4cY12bUJ7Cb61Mcs3HSsxGsut2r9Z89J
eUwGRL/Y3cW8zFeVZnywenL1vZuk4OOLbeAzOhH/IJbXP4K5juQeZXb8jCpLUKHXPGeuhcumJDr2
7f570xNdb7kE1shWARbLMCQD7vWi9VwQ8eyjB31DBQ==
=lv+S
-----END PGP SIGNATURE-----

--------------X2tBXwJJQ7URBhPPEYI3057i--

