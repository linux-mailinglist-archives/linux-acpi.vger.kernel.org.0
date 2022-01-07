Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F634870A9
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jan 2022 03:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345521AbiAGCmB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jan 2022 21:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344692AbiAGCl7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jan 2022 21:41:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A2CC061245
        for <linux-acpi@vger.kernel.org>; Thu,  6 Jan 2022 18:41:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id e5so3039862wmq.1
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jan 2022 18:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+dkiLt9yMO6x46qZW333QEXi70FYxlft58uImyv90V8=;
        b=TBhPVBC/jkLp44I13M14QBGq4++JyTLvhM9t9/BiD6tzhwqIeyI+jpqRFsaz0hDk9E
         1DS1rMZ9kFUKAEgcVMABa+NrP9LcXi3nuRlCFFLnZWGcuMZLosUkUKHjrvsAfg1b26IQ
         UVX56ya8eI6yqZfEn7zDR9irJmneZvhScojXkupFB5jddACdggSPan44OihLPqZsCQg4
         JsdJdIpgVim2E3RWeL7d4RzBS0li5W94FlFYwrhSZmH/RIrG11mvsdTKUDZUCsN6oV0L
         IqauN66XfkQDravH4K/F5tqX+Lhml/gBNLSRtLZZRcMM2RPfM8XDUmHmEIDtEer9FB+6
         4Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=+dkiLt9yMO6x46qZW333QEXi70FYxlft58uImyv90V8=;
        b=vjrBrNQmRPMUIOPs6tmbvKOPO8txsfE1tYYCk4+lqOBlt4rtA1z2Yv8co5B5rdbMAu
         S88diNFAyViZ760PhabQVofJJqRghBJ2OTNoZTS6Vrsd/SRkpMO1CXcEhXDwZNN+gw4O
         pucyt3NQajA1+FmP7LILnibkBsecTdTJTO+QrOfZQBsQh69aDOtg+RALEDKSXymrb5Oe
         rxsTS5cZ3OyZKYs6c4S5qm6cJ7HUBfaCbCvBb7z/Ol8WEoyy37IMGsXAEZfttoq8HjX4
         ZQODhtujsQypwXvNlWGdpSUC5JderKVG69VDhWU+VSOhFxId08MtkIh/kHojVO4jh+xm
         tEsw==
X-Gm-Message-State: AOAM532rACUouKATJNdB8sB022PYTAZg7Ymgj+ZcwfrX8fOA2uGW3JSX
        yGj3Wn6WO6kMlwOuMJJ8XWwVLfO+mIxcvSavCZw=
X-Google-Smtp-Source: ABdhPJzg2ZeP52lczkWB6S4jTa3M8TgncJZBLA4B68Uf/Btnpzphwr0fjmYWzH8DiFt/R4vq6FPbuHZ8P+LMbgKwv9Q=
X-Received: by 2002:a05:600c:1549:: with SMTP id f9mr9198605wmg.112.1641523316835;
 Thu, 06 Jan 2022 18:41:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:110c:0:0:0:0 with HTTP; Thu, 6 Jan 2022 18:41:56
 -0800 (PST)
Reply-To: mr.luisfernando5050@gmail.com
From:   "Mr. Luis Fernando" <kasimmohamed0099@gmail.com>
Date:   Thu, 6 Jan 2022 18:41:56 -0800
Message-ID: <CANUogzU-F7Lihau=_xOfGpptxndP3t6X1XEtAASPCrXTv2LOTA@mail.gmail.com>
Subject: GOOD DAY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

LS0gDQpJIGFtIE1yLmx1aXMgZmVybmFuZG8NCg0KSGkgRnJpZW5kIEkgd29yayBpbiBhIEJhbmsg
Zm9yIEFmcmljYSAoQk9BKSBoZXJlIGluIEJVUktJTkEgRkFTTw0KDQpJIHdhbnRzIHRvIHRyYW5z
ZmVyIGFuIGFiYW5kb25lZCBzdW0gb2YgMjcuNSBtaWxsaW9ucyBVU0QgdG8geW91DQp0aHJvdWdo
IEFUTSBWSVNBIENBUkQgLjUwJSB3aWxsIGJlIGZvciB5b3UuIE5vIHJpc2sgaW52b2x2ZWQuDQoN
Cg0KVGhlIChCT0EpIGJhbmsgd2FzIGJlaW5nIHVzZWQgYnkgbWFueSBBZnJpY2FuIFBvbGl0aWNp
YW5zIHRvIGRpdmVydA0KZnVuZHMgKHRoZSBQb2xpdGljaWFucyBsb290ZWQgb3ZlcjViaWxsaW9u
IFVuaXRlZCBTdGF0ZXMgZG9sbGFycykgdG8NCnRoZWlyIGZvcmVpZ24gYWNjb3VudHMgYW5kIHRo
ZXkgZGlkIE5vdCBib3RoZXIgdG8ga25vdyBob3cgbXVjaCB3YXMNCnRyYW5zZmVycmVkIGJlY2F1
c2UgdGhlIGZ1bmRzIGJlbG9uZ2VkIHRvIHRoZSAnU3RhdGUnIHRoYXQgaXMgd2h5IEkNCmFsc28g
ZGVjaWRlZCB0byBwdXQgYXBhcnQgdGhlIHN1bSBvZiAgJDI3LjVtaWxsaW9uIERvbGxhcnMgd2hp
Y2ggaXMNCnN0aWxsIGluIG91ciBiYW5rIHVuZGVyIG15IGN1c3RvZHkgZm9yIGEgbG9uZyBwZXJp
b2Qgbm93IQ0KDQpJIGhhdmUgdG8gZ2l2ZSB5b3UgYWxsIHRoZSByZXF1aXJlZCBndWlkZWxpbmVz
IHNvIHRoYXQgeW91IGRvIG5vdA0KbWFrZSBhbnkgbWlzdGFrZS4gSWYgeW91IGFyZSBjYXBhYmxl
IHRvIGhhbmRsZSB0aGUgdHJhbnNhY3Rpb24gQ29udGFjdA0KbWUgZm9yIG1vcmUgZGV0YWlscy4g
S2luZGx5IHJlcGx5IG1lIGJhY2sgdG8gbXkgYWx0ZXJuYXRpdmUgZW1haWwNCmFkZHJlc3MgKG1y
Lmx1aXNmZXJuYW5kbzUwNTBAZ21haWwuY29tKSBNci5sdWlzIEZlcm5hbmRvDQoNCg0KDQoNCg0K
DQrmiJHmmK/ot6/mmJPmlq/Ct+i0ueWwlOWNl+WkmuWFiOeUnw0KDQrll6jvvIzmnIvlj4vvvIzm
iJHlnKjluIPln7rnurPms5XntKLnmoTkuIDlrrbpnZ7mtLLpk7booYwgKEJPQSkg5bel5L2cDQoN
CuaIkeaDs+mAmui/hyBBVE0gVklTQSBDQVJEIOWwhuS4gOeslOW6n+W8g+eahCAyNzUwIOS4h+e+
juWFg+i9rOe7meaCqO+8jDAuNTAlIOWwhuaYr+e7meaCqOeahOOAgiDkuI3mtonlj4rpo47pmanj
gIINCg0KDQrorrjlpJrpnZ7mtLLmlL/lrqLliKnnlKggKEJPQSkg6ZO26KGM5bCG6LWE6YeR77yI
5pS/5a6i5o6g5aS65LqG6LaF6L+HIDUwDQrkur/nvo7lhYPvvInovaznp7vliLDku5bku6znmoTl
pJblm73otKbmiLfvvIzku5bku6zkuZ/mh5Llvpfnn6XpgZPovaznp7vkuoblpJrlsJHvvIzlm6Dk
uLrov5nkupvotYTph5HlsZ7kuo7igJzlm73lrrbigJ0NCuS4uuS7gOS5iOaIkei/mOWGs+WumuaK
iueOsOWcqOmVv+acn+S/neeuoeWcqOaIkeS7rOmTtuihjOeahDI3NTDkuIfnvo7lhYPliIblvIDv
vIENCg0KICDmiJHlv4Xpobvnu5nkvaDmiYDmnInlv4XopoHnmoTmjIflr7zmlrnpkojvvIzov5nm
oLfkvaDlsLHkuI3kvJrniq/ku7vkvZXplJnor6/jgIIg5aaC5p6c5oKo5pyJ6IO95Yqb5aSE55CG
5Lqk5piT77yM6K+36IGU57O75oiR5LqG6Kej5pu05aSa6K+m5oOF44CCIOivt+WbnuWkjeaIkeea
hOWkh+eUqOeUteWtkOmCruS7tuWcsOWdgA0KKG1yLmx1aXNmZXJuYW5kbzUwNTBAZ21haWwuY29t
KSBNci5sdWlzIEZlcm5hbmRvDQo=
