Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C54FAAA0
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2019 08:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfKMHHk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Nov 2019 02:07:40 -0500
Received: from canardo.mork.no ([148.122.252.1]:43411 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfKMHHk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Nov 2019 02:07:40 -0500
X-Greylist: delayed 873 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 02:07:39 EST
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id xAD6qhtS001240
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Nov 2019 07:52:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1573627964; bh=vWlo2zKnqA7YLd4/HcizrxeoV7pJ6radYKv7BLbbwk4=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=EvgntLeY74hsU2DKC5EcE5tk35QqkYhtwSSk4xumvmjnij6QUCQ51q7hyNicT3+S8
         Zs4znitKJ+3ySbb4jO+0hjM2N9Q5hAD+3jcgvx8Ip5qBmdqMpPngNbuVNz72UlBN7o
         DZPHUw0dIO1Uv7N3+qskc1hzsUyOGbMnQUsK7t9U=
Received: from bjorn by miraculix.mork.no with local (Exim 4.92)
        (envelope-from <bjorn@mork.no>)
        id 1iUmWB-0000N0-Me; Wed, 13 Nov 2019 07:52:43 +0100
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v8 1/6] software node: rename is_array to is_inline
Organization: m
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
        <20191108042225.45391-2-dmitry.torokhov@gmail.com>
Date:   Wed, 13 Nov 2019 07:52:43 +0100
In-Reply-To: <20191108042225.45391-2-dmitry.torokhov@gmail.com> (Dmitry
        Torokhov's message of "Thu, 7 Nov 2019 20:22:20 -0800")
Message-ID: <87woc4s1xg.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.101.4 at canardo
X-Virus-Status: Clean
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> We do not need a special flag to know if we are dealing with an array,
> as we can get that data from ratio between element length and the data
> size, however we do need a flag to know whether the data is stored
> directly inside property_entry or separately.

Doesn't a non-null prop->pointer tell you this?

And inverting the flag is unnecessarily risky IMHO. An all-zero prop
might now result in dereferencing a NULL prop->pointer instead of using
the empty prop->value.  Now I haven't looked at the code to see if this
is a real problem.  But I believe it's better not having to do that
anyway...


Bj=C3=B8rn


