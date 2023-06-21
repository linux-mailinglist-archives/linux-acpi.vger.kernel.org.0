Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A22A737B0E
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jun 2023 08:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjFUGIU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Jun 2023 02:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjFUGIN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Jun 2023 02:08:13 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECAB1730
        for <linux-acpi@vger.kernel.org>; Tue, 20 Jun 2023 23:08:09 -0700 (PDT)
Date:   Wed, 21 Jun 2023 06:07:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687327684; x=1687586884;
        bh=ubPaVyZowGktzCcEYffuW++8GPJVzBrtENIQ7uYjie0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=eSNWl+3DJpvQHCiraPqTyJlsxcW7+N/gjjYZYCKXlSRVDs3jbcR2adXUJ7jdnAqdp
         VQZVjHJIbCMJJVikX7dZ7H0x7gbQd4RfkZ3pHn0utr17fhULg63/+VDxU1C/Rz29xg
         h1DdG0TddsZVWnZL1rXKhreRwVmVRXz2lB6crP8LdvgnaojSUxn+xIfIrqzCGOhGPw
         p6PBmP6j0T4RGKP7stxbvyJqrJCwVlIzyOkauM9mdcos+SRtwCtWdNiVUDirPhwITp
         LPnieK7n4nYWZ2JbgdG7Prhj05nEKuyCoOqrS4xCCH5/DDmkNJzcoiTApvgRfVW/4/
         81QKQIKZoxd7A==
To:     Bagas Sanjaya <bagasdotme@gmail.com>
From:   Sami Korkalainen <sami.korkalainen@proton.me>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Subject: Re: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
Message-ID: <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
In-Reply-To: <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch>
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me> <ZHFaFosKY24-L7tQ@debian.me> <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me> <ZIcmpcEsTLXFaO0f@debian.me> <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me> <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch>
Feedback-ID: 45678890:user:proton
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_xW5OBqT6eYXTEKbSnFLDvGSiisfLN9WDGQYH44fZg"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--b1_xW5OBqT6eYXTEKbSnFLDvGSiisfLN9WDGQYH44fZg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I bisected again. It seems I made some mistake last time, as I got a differ=
ent result this time. Maybe, because these problematic kernels may boot fin=
e sometimes, like I said before.

Anyway, first bad commit (makes much more sense this time):
e7b813b32a42a3a6281a4fd9ae7700a0257c1d50
efi: random: refresh non-volatile random seed when RNG is initialized

I confirmed that this is the code causing the issue by commenting it out (s=
ee the patch file). Without this code, the latest mainline boots fine.

Terveisin
Sami Korkalainen
--b1_xW5OBqT6eYXTEKbSnFLDvGSiisfLN9WDGQYH44fZg
Content-Type: text/x-patch; name=patch.diff
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=patch.diff

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2VmaS5jIGIvZHJpdmVycy9maXJtd2Fy
ZS9lZmkvZWZpLmMKaW5kZXggYWJlZmY3ZGMwYjU4Li5jMzYyYzgwN2Y1ZDYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZmlybXdhcmUvZWZpL2VmaS5jCisrKyBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL2Vm
aS5jCkBAIC0zNjAsNyArMzYwLDcgQEAgc3RhdGljIHZvaWQgX19pbml0IGVmaV9kZWJ1Z2ZzX2lu
aXQodm9pZCkKICNlbHNlCiBzdGF0aWMgaW5saW5lIHZvaWQgZWZpX2RlYnVnZnNfaW5pdCh2b2lk
KSB7fQogI2VuZGlmCi0KKy8qCiBzdGF0aWMgdm9pZCByZWZyZXNoX252X3JuZ19zZWVkKHN0cnVj
dCB3b3JrX3N0cnVjdCAqd29yaykKIHsKIAl1OCBzZWVkW0VGSV9SQU5ET01fU0VFRF9TSVpFXTsK
QEAgLTM3OCw3ICszNzgsNyBAQCBzdGF0aWMgaW50IHJlZnJlc2hfbnZfcm5nX3NlZWRfbm90aWZp
Y2F0aW9uKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsIHVuc2lnbmVkCiAJcmV0dXJuIE5PVElG
WV9ET05FOwogfQogc3RhdGljIHN0cnVjdCBub3RpZmllcl9ibG9jayByZWZyZXNoX252X3JuZ19z
ZWVkX25iID0geyAubm90aWZpZXJfY2FsbCA9IHJlZnJlc2hfbnZfcm5nX3NlZWRfbm90aWZpY2F0
aW9uIH07Ci0KKyovCiAvKgogICogV2UgcmVnaXN0ZXIgdGhlIGVmaSBzdWJzeXN0ZW0gd2l0aCB0
aGUgZmlybXdhcmUgc3Vic3lzdGVtIGFuZCB0aGUKICAqIGVmaXZhcnMgc3Vic3lzdGVtIHdpdGgg
dGhlIGVmaSBzdWJzeXN0ZW0sIGlmIHRoZSBzeXN0ZW0gd2FzIGJvb3RlZCB3aXRoCkBAIC00NTAs
MTAgKzQ1MCwxMCBAQCBzdGF0aWMgaW50IF9faW5pdCBlZmlzdWJzeXNfaW5pdCh2b2lkKQogCWlm
IChlZmkuY29jb19zZWNyZXQgIT0gRUZJX0lOVkFMSURfVEFCTEVfQUREUikKIAkJcGxhdGZvcm1f
ZGV2aWNlX3JlZ2lzdGVyX3NpbXBsZSgiZWZpX3NlY3JldCIsIDAsIE5VTEwsIDApOwogI2VuZGlm
Ci0KKy8qCiAJaWYgKGVmaV9ydF9zZXJ2aWNlc19zdXBwb3J0ZWQoRUZJX1JUX1NVUFBPUlRFRF9T
RVRfVkFSSUFCTEUpKQogCQlleGVjdXRlX3dpdGhfaW5pdGlhbGl6ZWRfcm5nKCZyZWZyZXNoX252
X3JuZ19zZWVkX25iKTsKLQorKi8KIAlyZXR1cm4gMDsKIAogZXJyX3JlbW92ZV9ncm91cDoK

--b1_xW5OBqT6eYXTEKbSnFLDvGSiisfLN9WDGQYH44fZg--

