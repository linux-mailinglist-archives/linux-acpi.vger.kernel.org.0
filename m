Return-Path: <linux-acpi+bounces-12082-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75FEA5BFE9
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 13:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069E27A3A63
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5469F221F0F;
	Tue, 11 Mar 2025 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DFYWG/si"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3073597C;
	Tue, 11 Mar 2025 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694462; cv=none; b=ASGBK845XRmsI91DvfOsMw6ZgvsQiPKecTUQu8zPsbnYP+mV540gVl75VA76/1eGsXuvTrZfJ/NAGR0vSIa9V67wb2pe8hvojeBBCdvuB6C+6eeDYxEsNScsTyXesgqhjVnJtsNAubBJT+d9JJdAjO7UVKXCqiRnxJ5A0kaPLlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694462; c=relaxed/simple;
	bh=1po9kPpQ5NSe95BZBG3yLS0Kw6JEa7dbgysMQJ2FGYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C05xlg0lRYTNdYa96GGzt2rASu3dS8HDAaZf5rmwhwxC48apN1FCZWta3I83BPM6u/Srr+sw79rCT5LKM/+J7oz+5T4p6dDsHK77gl2gjxnu1gMNNy/PTjV++9IUGcjw7QxjoBu8RMnxMpZrhahXOWI0jbJ2zrdiDfTpDO6jbcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DFYWG/si; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741694421; x=1742299221; i=markus.elfring@web.de;
	bh=1po9kPpQ5NSe95BZBG3yLS0Kw6JEa7dbgysMQJ2FGYA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DFYWG/siRh0Mh/2be3tAPCHYrqeeu0/+cHC14EWXnBOem63oJzDXMoohArMYAT0P
	 utdEpb3PlH/NH4mHcvvApNBhWZyEMXqUx66l8VnTqDt+9zkMgHlZ2Svmh5LslMC9H
	 CsAst5VWlRAYT/3McvxAmqzg9G3Z3XUfEix1etePWq3elzVe6U34HhS/iqRb/Zrwg
	 pUu9tyoyiM9n0QTYUnEV9vq+nWLo81HkG6caRbHxeE0oxIFrQ0X2y0mXWBB+b52vc
	 aduFyui07XuG+hVWr0vOpUhp0ijBP3VBkt2TDCK2oTqmD84qSxArWhWQj8ZgFUrCG
	 mfa5++zL1WOlYlXcAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.40]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP3CC-1tZMWv1jqO-00VlJ9; Tue, 11
 Mar 2025 13:00:21 +0100
Message-ID: <bf26ba74-ff44-4642-864e-2c54d49ead74@web.de>
Date: Tue, 11 Mar 2025 13:00:16 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] device property: Split fwnode_get_child_node_count()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-acpi@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Jakob Riepler <jakob+lkml@paranoidlabs.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Scally <djrscally@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lee Jones <lee@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Pavel Machek <pavel@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
 <20250310150835.3139322-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250310150835.3139322-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q/a3GCeWD3iUFv6+3kpvObqx+Bs4+4nh6EgTLERJ3lTZ1L52yrg
 Q2VwG9XADV/Ol9rBvkHE9v7/VSYnZeBq+K12f5MpvIUNTVqFeExkLvdolfJKEN1vU5XPP1I
 oeEf8/hlStMfKsV6QZRn7ejw42fIEuDEbzUmonLDw+2E03UJ7UkHaBHIt6wvvfOazNW4Wem
 q3vahFzBH9NvO9iYRb5CA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M0Vtme7G86E=;Z4oV0SEqDKd1dI2BbPj5sTxr7dv
 9kx9rhCJNbUFO7cYtCYt12hgM20h1d5bcYz9n/9Z5XW0shX9AJZ78iKFb4wcH9Ir2rdUcTVVo
 PRz2SysCb/frPHYUA/TNQoPI91FJzflnEvtLj3DvX3v+ULH1qtgUzcLroRWOGm7GdFFjL2lYT
 s2aqDca1l4mGYB9J4MyxdmPykJtpFtnZRzSnlu+w6KdvgZX+k8jA4sYX2Ad0Ba3NHWlrZqB4x
 IjZMOnqNJBEiSN8lbfYPsUL0C3M5UEQwIZlBX4iVc5qcX/K42ChZudsL7JlC19sNIESmCMcLv
 wZn9AXGROECKN9JtDnuLJtXTl3Imkos7T6pROa7YaJo1JfcWS11dTeR20ovhHXquLkZz35YJV
 vVKnxittJ6rv4xfYcoey1sFk0yVPGa09OzzkyLniYoOo6hBfmRkjEn3PQ/0BPzpI/tNs+4kHb
 YC9a9gIaIGVYBsJEEzXltXqOhlH2kAm5Ai+uD74LTatv+rX5URneTV9jddiXggcSmoBa56SvT
 60yRlhwWsA5gWRnDPsWDHYTimTqTz24ARvRgWmJ6f05QGdtrC9YYxs4uFz/Twga1h1XSov7VO
 4otoTQDBh2KWhX64CsC7/bq3HSrHAeAOELyPGm2CA+xXnNnSPem735RzBgMqTdvCt/Mtf4/e+
 JVy8K7QJkUEAInDt66QZUrSYpZVH9WecY9TLD6QAai7D9mAqUDGcMEb+PKATbua/zpzMCy3w/
 TixFfrOJNpQvTpsrSREN+hzn1XVuISafELT5B4xUkQFYVXGS8P7SQhLaR7QUKd2APX81fqD1A
 J56oET7hkOFagf2Jo7kx4NBy/bd1gKzh8R5n1A1A8k0hKwaHmGZOXa7hoTiWiWCVVBfVnOuo/
 8dxm5R+2nS5MO0nU5CHrfNACy55eSUCNcZEvEYPwJd1V7Pv5V9/QqCosA6D4hU2/z/HUjAf4M
 b/x2EQJyJVWuS8h38RNPrDSqwLOhMOTE/MFIQ0mmKcZJ2i1SNM3vdTDN7qGLdTCpopG5/J6j+
 FNQlw4NjtoS9eMo1rrD5q7Loe1QhXleQ34VdP1iXs5x87i4AzjYWoc7PmbEitItF64UAgKfP3
 TpGUCz+4Nju6sKJsVBs6TbitlVQNmQ18xXGnXMnD4AAATq5BH4nyhEL9zxirrufwRJEdeyQA3
 is2CXBAERevsmiSGxF0MhTrHvX2QJC8OfoKi17zo4sXSZ3g5c0D4LY875A8rJkcF0X/qjrHJa
 CTFA7kD4NueAwZodu9RxIJmrm3jr2xOCNXlKE6O7E1e7R0m3qJ+H+kiNkQUE4cB2vSQ9SG9Ko
 Jiq3qZCOlWVD6om6KyH/jM8TbpOkHDnMHmbbfHYnFNr6NWJ22L8SlfqLdhX0JikbxQgTNVrr0
 RDE4B3D8TgHKlT0sT8AfeB9zyU7HeSmjRZp9tSNKMFSpGs2RITDORU5oNSmCta+LN6WcdWJS9
 8xaNWEg==

> The new helper is introduced to allow counting the child firmware nodes
> of their parent without requiring a device to be passed. =E2=80=A6

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14-rc6#n94

Regards,
Markus

