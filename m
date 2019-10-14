Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E6ED6C03
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 01:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfJNX23 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Oct 2019 19:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfJNX23 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Oct 2019 19:28:29 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA62E217F9;
        Mon, 14 Oct 2019 23:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571095709;
        bh=/T9FxcxpIR4sdkUijVa3Y0FNoBc6Tptc8qvATswzwJ0=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=w9AsmgxOwKFvr2df+N4+IZcU/xMRmyRtJYEGMokBf0bZDs47+2rCRZ9IoG1IRnjS6
         glrFxA+AwdKLg2qwPdKBxrl1ApITMqTyZsKoL5sEqSWamWVIwL4IE1BRfOwSTVmY3B
         WeD0fYgZ1mgdAoJqa4YBA+QhNvtbJ2RI7cNBlsKg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191011191521.179614-4-saravanak@google.com>
References: <20191011191521.179614-1-saravanak@google.com> <20191011191521.179614-4-saravanak@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 3/3] docs: driver-model: Add documentation for sync_state
User-Agent: alot/0.8.1
Date:   Mon, 14 Oct 2019 16:28:28 -0700
Message-Id: <20191014232828.DA62E217F9@mail.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Quoting Saravana Kannan (2019-10-11 12:15:21)
> The sync_state() driver callback was added recently, but the
> documentation was missing.  Adding it now.
>=20
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  .../driver-api/driver-model/driver.rst        | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>=20
> diff --git a/Documentation/driver-api/driver-model/driver.rst b/Documenta=
tion/driver-api/driver-model/driver.rst
> index 11d281506a04..baa6a85c8287 100644
> --- a/Documentation/driver-api/driver-model/driver.rst
> +++ b/Documentation/driver-api/driver-model/driver.rst
> @@ -169,6 +169,49 @@ A driver's probe() may return a negative errno value=
 to indicate that
>  the driver did not bind to this device, in which case it should have
>  released all resources it allocated::
> =20
> +       void (*sync_state)(struct device *dev);

This is only in -next as far as I can tell. Will this be combined with a
resend of the patch series that introduces this hook?

