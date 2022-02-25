Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304CF4C3A81
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 01:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiBYAuR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Feb 2022 19:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbiBYAuR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Feb 2022 19:50:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EC42C0335;
        Thu, 24 Feb 2022 16:49:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24EF1B82A7C;
        Fri, 25 Feb 2022 00:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8EDC340EF;
        Fri, 25 Feb 2022 00:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645750183;
        bh=/gjfyXft3KepKTQGQRWa22PpJYtYND6chFxYq2s6++s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Osej/u5wUspxVqADMrgvgoC5FXMvyHDkHZW4fBJ1kgFe1+EKJFtljIZYJhQnFMHnB
         6B2AMVFTv+WbbL5IV+/Bgq70y+YevqLtpWLNfmmB+SADRrSDkwIJw7suwxnQrAz074
         6k5eD73lafLOJkdIj1k2/mEbD4dIlFFyxc1u8Lq77F1Q5ezIjtZ6UlQeB8G5RUrk/r
         6CgFL6QrUg7V4vpBLk4jkbxv9mZ/MLvXSCbcOWR3Nd/ESbF2KYIhOh0dYb87wHpya3
         KaI4/FGdO4SeKfmLCGq+owJAwN2gm/SxIfHiAaGa+TRXkg0NU9Fd9fskn42WAl04Gk
         9FKPxFUgjkfMA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c7d1539f-01a2-299d-ca4f-8e60cfe71775@redhat.com>
References: <20220216225304.53911-1-djrscally@gmail.com> <20220216225304.53911-4-djrscally@gmail.com> <c7d1539f-01a2-299d-ca4f-8e60cfe71775@redhat.com>
Subject: Re: [PATCH 3/6] platform/x86: int3472: Support multiple clock consumers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     rafael@kernel.org, lenb@kernel.org, markgross@kernel.org,
        robert.moore@intel.com, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, platform-driver-x86@vger.kernel.org
To:     Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 24 Feb 2022 16:49:41 -0800
User-Agent: alot/0.10
Message-Id: <20220225004943.AA8EDC340EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Quoting Hans de Goede (2022-02-21 01:59:09)
> Hi,
>=20
> On 2/16/22 23:53, Daniel Scally wrote:
> > At present, the int3472-tps68470 only supports a single clock consumer =
when
> > passing platform data to the clock driver. In some devices multiple
> > sensors depend on the clock provided by a single TPS68470 and so all
> > need to be able to acquire the clock. Support passing multiple
> > consumers as platform data.
> >=20
> > Signed-off-by: Daniel Scally <djrscally@gmail.com>
>=20
> Thanks, patch looks good to me:
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Michael, I plan to merge this entire series through the platform-drivers-=
x86 git
> tree, may I have your ack for merging the clk bits from this ?
>=20

With the type fix

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
