Return-Path: <linux-acpi+bounces-4572-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5878689299A
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Mar 2024 08:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F02283281
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Mar 2024 07:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7535915C9;
	Sat, 30 Mar 2024 07:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Gkcdic5f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Te5ANeTJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623C7FB
	for <linux-acpi@vger.kernel.org>; Sat, 30 Mar 2024 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711782037; cv=none; b=Et/u1b01ubLXWvjTdfC6iXtGI0LXFiUOtHyS7GHP9e/1waks8VeiFimwx6JUfpvxAjMQ01R2KRn/uPqeqTzEqE5kD7NYYzIB8OLSrs+QX4OKFMBww+Zhicdmnp4mrSBNRRHCPoBWj7NOCA3P+i86dK9qC7T28YNuy+3VTihU4cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711782037; c=relaxed/simple;
	bh=luQuQt0cywrwnxZrfSoUMvqzYD0+ZW8E9d6RGOc/eW0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ic5gr6Rl+Pb+xd+/SxKGBO7McQusA6Wvi7LWCTcqVkSBKZuDsKls3Aqvk7Ipte5Si6WvqMjtruLfvvAhASB8UOdgPHo892W1CUEiOayX+Ml9zDXgbaWIOQ57wWwKlO74rBm29oNUrrrSPeX1XxdXmM8UEZqX4s6ato+fvAtRoQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Gkcdic5f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Te5ANeTJ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1FFAA138010F;
	Sat, 30 Mar 2024 03:00:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 30 Mar 2024 03:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711782034;
	 x=1711868434; bh=Ur/nT5RbykWH2DvGLVa7v7x6kXVV495L2a3dmor8HDw=; b=
	Gkcdic5fp0ZPEE0cpvbyVNIGq0xD1SKOQ20gaY9qFPXaftrPxOV0eHX8Cm90fB1j
	EdvChwj9Z3SkWe4tIyWrCatf5kJElHxGcBZvj1M9CXdQtcRgKKu+ZLxziCb4BFiw
	Wlw8dp/aVmw6pPT/YOOtpdWYvaPY6wAwZYYs9IROdJd+uLpVODsplvKrcNayvHTc
	+Ybgb1T3nAjwdlaZSi0GzZz5Aj2qQx++2Bkc7Z3QkCA8pORwA0JpGXYp60LHEpzQ
	zMMWnRfQnMnRyCKx23/IEGyPa2Y7766YlfRd9falR5RartAo+CKV1miDbC+QktAh
	yZJn2/5R4IdaheeqPIJAdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711782034; x=
	1711868434; bh=Ur/nT5RbykWH2DvGLVa7v7x6kXVV495L2a3dmor8HDw=; b=T
	e5ANeTJmKsUF0CujRvn7FY/R0HpQPeTk4kwtv/AFKUSOm5xJ5Iplw8dCujsInbfX
	ATH4dkG5XL3Uz3/mUoHA4aOAA10J9JOkTHnasaty5LHcAbi+fD5A9X/faVJmzN9s
	XprC7AZDUb57jDG1/x3AzTTZb2BPwjIzZu/wTSNFWMLh9axlMnJXLvvb85/k6lsw
	bD3xKK9O5h5VOcmiAIdhAgFac2z83O1csn0FoVYKOt0VJMzP1KMggv5eSE2+aHqp
	xBdvTDhTW9PXwnSE3gwZl9jNEPfXitd8WMbtlxTwT4ok7SV1/VSEJRKR2SdE9T1e
	VsVx12HC8ce2MxK5tTH4g==
X-ME-Sender: <xms:kbgHZmF5Ds9B3lNiLN2MVUw2zDAHcqhVZO0U9WnH_JECexIwxd22bw>
    <xme:kbgHZnXwmHXU1mqLV7ffq7hW-ENAixlMRXbfO4Ty9jJMsErlMKaWwK1cOqoBoN3Ue
    mnFLijUxnzmdE7bvrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvfedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kbgHZgLYY5OTB7Juk3kmLKeICSR5B98P38jYsQeb-2yO9Sqlv1nxsQ>
    <xmx:kbgHZgExUJi2vhyEQ8qEUphBEFJfQDde09bDSf6hMacS2ZVMUENAjQ>
    <xmx:kbgHZsWHWy3vdh7fPoGTuMuu7KeXZwV9HQFai3GzmLYj2Vbzp1Eqyw>
    <xmx:kbgHZjNpdgxMqwlApRxGGQKiCziuTM-be1ZfkcEQFckMaTOxNAzfRA>
    <xmx:krgHZts3SBcxSXFdWG5RuUqU46gIOj8LEoy4cajtnz_ZHCsDACh0rQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 16B74B6008D; Sat, 30 Mar 2024 03:00:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <53480b07-612f-4701-bcd5-bb677701b00e@app.fastmail.com>
In-Reply-To: <20240329100203.540368-2-u.kleine-koenig@pengutronix.de>
References: <20240329100203.540368-2-u.kleine-koenig@pengutronix.de>
Date: Sat, 30 Mar 2024 08:00:32 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Dan Williams" <dan.j.williams@intel.com>
Cc: "Len Brown" <lenb@kernel.org>, "James Morse" <james.morse@arm.com>,
 "Tony Luck" <tony.luck@intel.com>, "Borislav Petkov" <bp@alien8.de>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Avadhut Naik" <Avadhut.Naik@amd.com>,
 "Ben Cheatham" <Benjamin.Cheatham@amd.com>, linux-acpi@vger.kernel.org,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>
Subject: Re: [PATCH] ACPI: APEI: EINJ: mark remove callback as __exit
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024, at 11:02, Uwe Kleine-K=C3=B6nig wrote:
> The einj_driver driver is registered using platform_driver_probe(). In
> this case it cannot get unbound via sysfs and it's ok to put the remove
> callback into an exit section. To prevent the modpost warning about
> einj_driver referencing .exit.text, mark the driver struct with
> __refdata and explain the situation in a comment.
>
> This is an improvement over commit a24118a8a687 ("ACPI: APEI: EINJ: ma=
rk
> remove callback as non-__exit") which recently addressed the same issu=
e,
> but picked a less optimal variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I noticed another curiosity:

>  static struct platform_device *einj_dev;
> -static struct platform_driver einj_driver =3D {
> -	.remove_new =3D einj_remove,
> +/*
> + * einj_remove() lives in .exit.text. For drivers registered via
> + * platform_driver_probe() this is ok because they cannot get unbound=
 at
> + * runtime. So mark the driver struct with __refdata to prevent modpo=
st
> + * triggering a section mismatch warning.
> + */
> +static struct platform_driver einj_driver __refdata =3D {
> +	.remove_new =3D __exit_p(einj_remove),
>  	.driver =3D {
>  		.name =3D "acpi-einj",
>  	},

I was wondering why this doesn't cause an "unused function"
warning for einj_remove(), given that __exit_p() turns the
reference into NULL.

As it turns out, the __exit annotation marks the function as
"__attribute__((used))", so it still gets put in the object
file but then dropped by the linker. The __used annotation
seems to predate the introduction of "__attribute__((unused))",
which would seem more appropriate here, which would allow
more dead-code elimination.

The patch below gets rid of the __used annotation completely,
which in turn uncovers some interesting bugs with __exit
functions in built-in code that are never called from
anywhere, like

drivers/video/fbdev/asiliantfb.c:627:20: error: 'asiliantfb_exit' define=
d but not used [-Werror=3Dunused-function]

     Arnd

diff --git a/include/linux/init.h b/include/linux/init.h
index 58cef4c2e59a..d0e6354f3050 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -82,7 +82,7 @@
 #define __exitused  __used
 #endif
=20
-#define __exit          __section(".exit.text") __exitused __cold notra=
ce
+#define __exit          __section(".exit.text") __cold notrace
=20
 /* Used for MEMORY_HOTPLUG */
 #define __meminit        __section(".meminit.text") __cold notrace \
@@ -394,7 +394,7 @@ void __init parse_early_options(char *cmdline);
 #ifdef MODULE
 #define __exit_p(x) x
 #else
-#define __exit_p(x) NULL
+#define __exit_p(x) (0 ? (x) : NULL)
 #endif
=20
 #endif /* _LINUX_INIT_H */

