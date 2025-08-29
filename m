Return-Path: <linux-acpi+bounces-16179-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A355AB3B9FF
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 13:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9747B82D2
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 11:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A162C08A8;
	Fri, 29 Aug 2025 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCtideYJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ACD2BE63D;
	Fri, 29 Aug 2025 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467271; cv=none; b=nJ89KDvcSDAA5/T2qrieTOYPEmbbUlhUyh3tr0nq3YNGDpsLxaDGN3JCe8nYA0naOOUXBYtnMimUlAbxdKbFopMZ66ukAXQ8RFtk1wF/cm9D7UgWKuEL+6HkIrZLoxa9hm9fpRM1rN1zESNT5pvLbWM+W5M7o3rkwAJEwxPKys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467271; c=relaxed/simple;
	bh=QPUeMfmXVN9BTm6u37xd2AlNGeLZnzJ86ronKP90K/s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YWEXdCO8FiEl34lp4fmRVDp7nwUZd13fZj0zlFYdsm7Bqj9LYDtxYDzMjT0N7N4soWrsOcFB8FKYNhFxne4KPgPowV4lgIOr1eeot1Z5vFXGbFrmEoegPMo6GbX49i5gl9TCXrYEyoMVWH19ZGGYDlfqsi/04eopwG09vz8HO7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCtideYJ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e872c3a0d5so204880185a.2;
        Fri, 29 Aug 2025 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756467269; x=1757072069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rDEscnLz/BZA8JwgnDnrvbiTiHOARNFbxAuWjkJjonE=;
        b=jCtideYJARuxn/P+8gvHHghnPpb57r3jaIt/4kHlVq8cnPhObZXyaDcuQhBti8eAlw
         YuNIdh1VGDPfV4v8o3ySxXAy8QNhO8rXkekfW6IelM2hJ53yPCQRV1UiRaCMEOJ9cNaN
         blcRbqBPx9GtlGtmwmhMZYfVqLWy+Ih1WZJXfRJ7/ptw6MAttFKftT3f7//+JQiTtu3G
         vfjOCLzBX3U7cr+H1Bjpp7mdmUucJogG9J11bDz2hIdriptVhDki0qpszf3ak4UeVqXo
         /BrPUNgokmtCaRgUlxs4de/LeMZwX6iZqO+dF47sBVTEWIiIxQTRYPV33b0pVFtKv/AC
         LaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756467269; x=1757072069;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDEscnLz/BZA8JwgnDnrvbiTiHOARNFbxAuWjkJjonE=;
        b=t+BucQdsi8QVvnOWkdFNOX55G9/LI/+fhZ5XArf80ZMfSOPqjOGcqyzVxk0WDZkAFU
         NF6cLN0WKMMhlFRfMCgcumTetnsTQXDBEwIBTD6wC+wKl4CH2tut6e1SXHd2W5ekl7u+
         fFw3Xb5QyekJ1LpmM3Wa1uv2AsKK3aefly/tHCa6RyuFPVNC38ay8fTrajTEX4HwMALg
         WMGj2tI33H+ledO6qbPBXYrsqMxovw45xPR2SvcFRSqWdIEXiZ0G+yodzhAamVPBskox
         zrUWkKYg2onI/FU8UHmQLXOxOzQ2V+d2vBcapfjRidAp3AqWPYHOditwAsfDPb9K+Crg
         uVMw==
X-Forwarded-Encrypted: i=1; AJvYcCW2S/1d9IwKTl30wfyYD8M1gD9ByvIvgCj9zbYFy5qlf8dNKJZd2d++8de7FcgPqqqGwniM6/xLKD7d2YaV@vger.kernel.org, AJvYcCWTyrz/8RIYyNUjpsHWmcUrI/dK94AIJ3dJ28Hdy6vI1Ij961RedY9u9a1iLZDrse8EobjoF1YuRhIu@vger.kernel.org
X-Gm-Message-State: AOJu0YyHyCU8ARlLjkXTSUOPgNe5uRMKPJ7FS5icYoyyr9TrkKwj4Svp
	iwsjMQDpurOq5O0ne/eeRJyxwDIuX1fOAI0mWzm/0Ss0uAEWm54KJ/zT
X-Gm-Gg: ASbGnctWzy5YCKQF+couFYBhSccVLPaUknlc/nxiqvC1WURNrG86ypLrKxrURCNaELs
	pBpqrzJb0vXr7sKLD3TFLw1yon9PU/qqUzt5l96j380rgc7OKfJzG9moJ66EF2ZQ0jtgsQrwdUa
	DK58OHb7S6Q12FRkOkIif8C9PPDcQJ17rB5/aOuLZWvHGN5uF3GKlboxKr6OHJRXnweb8kblIU4
	q5wmRZdwYgog/w1XW5B/tx0/fcgVo/s0Gaz2afnqVtW+SJntz9LDe3idR9JCen0JCTRigvBa9xS
	NPM75fhyOtM8CgIKY2FbPs5ty+U5f8aGyH6VQiv/0q3SrVdtY7NzYCXNSmItBETC17chXLdUqqu
	TijknecRjPzRIL2tOmSiZqcKERzvGtnZ/aHmACDvNDiRZhQtVLis2jWJn07OOwxtGG5ALl7DjuM
	v3kZ210T2EIBCj4D+T
X-Google-Smtp-Source: AGHT+IHW/sbnkDgC4yK/V9LuoDw6dZkOwz+ho8+4EZsZmHNQtoZnzT2+tABa57wUJqsoXSpR1f9sow==
X-Received: by 2002:a05:620a:40c3:b0:7f7:1a80:4ba7 with SMTP id af79cd13be357-7f71a804ef5mr865524785a.62.1756467268952;
        Fri, 29 Aug 2025 04:34:28 -0700 (PDT)
Received: from ehlo.thunderbird.net (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc1484e8e8sm154419885a.40.2025.08.29.04.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 04:34:28 -0700 (PDT)
Date: Fri, 29 Aug 2025 07:34:17 -0400
From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Lessard?= <jefflessard3@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device property: Add scoped fwnode child node iterators
User-Agent: Thunderbird for Android
In-Reply-To: <2025082953-splendor-unsold-e4f2@gregkh>
References: <20250829021802.16241-1-jefflessard3@gmail.com> <2025082953-splendor-unsold-e4f2@gregkh>
Message-ID: <AA99AF86-CD2A-4BBE-92BC-3D9005E7BA3B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 29 ao=C3=BBt 2025 00 h 23 min 22 s HAE, Greg Kroah-Hartman <gregkh@linux=
foundation=2Eorg> a =C3=A9crit=C2=A0:
>On Thu, Aug 28, 2025 at 10:17:59PM -0400, Jean-Fran=C3=A7ois Lessard wrot=
e:
>> Add scoped versions of fwnode child node iterators that automatically
>> handle reference counting cleanup using the __free() attribute:
>>=20
>> - fwnode_for_each_child_node_scoped()
>> - fwnode_for_each_named_child_node_scoped()
>> - fwnode_for_each_available_child_node_scoped()
>>=20
>> These macros follow the same pattern as existing scoped iterators in th=
e
>> kernel, ensuring fwnode references are automatically released when the
>> iterator variable goes out of scope=2E This prevents resource leaks and
>> eliminates the need for manual cleanup in error paths=2E
>>=20
>> The implementation mirrors the non-scoped variants but uses
>> __free(fwnode_handle) for automatic resource management, providing a sa=
fer
>> and more convenient interface for drivers iterating over firmware node
>> children=2E
>>=20
>> Signed-off-by: Jean-Fran=C3=A7ois Lessard <jefflessard3@gmail=2Ecom>
>> ---
>>=20
>> Notes:
>>     checkpatch reports false positives that are intentionally ignored:
>>     COMPLEX_MACRO, MACRO_ARG_REUSE, MACRO_ARG_PRECEDENCE
>>     This is a standard iterator pattern following kernel conventions=2E
>>=20
>>  include/linux/property=2Eh | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>=20
>> diff --git a/include/linux/property=2Eh b/include/linux/property=2Eh
>> index 82f0cb3ab=2E=2E279c244db 100644
>> --- a/include/linux/property=2Eh
>> +++ b/include/linux/property=2Eh
>> @@ -176,6 +176,20 @@ struct fwnode_handle *fwnode_get_next_available_ch=
ild_node(
>>  	for (child =3D fwnode_get_next_available_child_node(fwnode, NULL); ch=
ild;\
>>  	     child =3D fwnode_get_next_available_child_node(fwnode, child))
>> =20
>> +#define fwnode_for_each_child_node_scoped(fwnode, child)		\
>> +	for (struct fwnode_handle *child __free(fwnode_handle) =3D	\
>> +		fwnode_get_next_child_node(fwnode, NULL);		\
>> +	     child; child =3D fwnode_get_next_child_node(fwnode, child))
>> +
>> +#define fwnode_for_each_named_child_node_scoped(fwnode, child, name)	\
>> +	fwnode_for_each_child_node_scoped(fwnode, child)		\
>> +		for_each_if(fwnode_name_eq(child, name))
>> +
>> +#define fwnode_for_each_available_child_node_scoped(fwnode, child)	\
>> +	for (struct fwnode_handle *child __free(fwnode_handle) =3D	\
>> +		fwnode_get_next_available_child_node(fwnode, NULL);	\
>> +	     child; child =3D fwnode_get_next_available_child_node(fwnode, ch=
ild))
>> +
>>  struct fwnode_handle *device_get_next_child_node(const struct device *=
dev,
>>  						 struct fwnode_handle *child);
>> =20
>
>We need a real user of this before we can add them, so please do that as
>part of a patch series=2E
>

I understand the "no dead code" policy, but I found existing manual
implementations of this exact pattern in the current kernel=2E

For example, drivers/i2c/i2c-core-slave=2Ec already does:

		struct fwnode_handle *child __free(fwnode_handle) =3D NULL;
=2E=2E=2E
		fwnode_for_each_child_node(fwnode, child) {
=2E=2E=2E
		}

This suggests developers are already wanting this functionality but
implementing it manually=2E

If included with my driver series, I would only add the
fwnode_for_each_available_child_node_scoped() variant that I actually use,
avoiding any dead code=2E

Best Regards

Jean-Fran=C3=A7ois Lessard


