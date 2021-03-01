Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE59B328DF5
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Mar 2021 20:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241394AbhCATV0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Mar 2021 14:21:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:48572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235768AbhCATSz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 1 Mar 2021 14:18:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614626287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3j/0D9ZA7ezAtEP4Nk3+f0xENC++ECPVLz2dgRTsCxI=;
        b=r1srcnqfeZUiQ0xnlWVjFCTUVG4ZpnVmnB2gjAkhAjdEf+FPeRl4xZQT9zSl80nS50IY95
        liuwzkMBhoLK+WLikoku4/ZC03NEOaYPwZNXl5lEwsH0pwlAkM7n1NPNJGpOvDKMBGpFKP
        e8FDvOHsUgwj7WG4qSh5WrEHX0yApmM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 010B4AF35;
        Mon,  1 Mar 2021 19:18:07 +0000 (UTC)
Subject: Re: [PATCH v1] xen: ACPI: Get rid of ACPICA message printing
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org,
        Konrad Wilk <konrad.wilk@oracle.com>
References: <1709720.Zl72FGBfpD@kreacher>
 <eaeba4a0-7bb9-7b17-9ba6-49921f6e834c@oracle.com>
 <CAJZ5v0jr5Mxs9NYBz1ot8O+6dKYbfAo=cJqSVAOnrFEqUNwuTA@mail.gmail.com>
 <7c313ae8-6f3a-1281-a88a-1393e54f26a1@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <afc7b1af-4d12-fb06-9212-b828f4426073@suse.com>
Date:   Mon, 1 Mar 2021 20:18:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7c313ae8-6f3a-1281-a88a-1393e54f26a1@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Y6WqBR9s8HPASVufSY807FC9ROBrepWk0"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y6WqBR9s8HPASVufSY807FC9ROBrepWk0
Content-Type: multipart/mixed; boundary="IMu2UHGcUE6GoRXxvT3hkijSEV94m109Z";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Konrad Wilk <konrad.wilk@oracle.com>
Message-ID: <afc7b1af-4d12-fb06-9212-b828f4426073@suse.com>
Subject: Re: [PATCH v1] xen: ACPI: Get rid of ACPICA message printing
References: <1709720.Zl72FGBfpD@kreacher>
 <eaeba4a0-7bb9-7b17-9ba6-49921f6e834c@oracle.com>
 <CAJZ5v0jr5Mxs9NYBz1ot8O+6dKYbfAo=cJqSVAOnrFEqUNwuTA@mail.gmail.com>
 <7c313ae8-6f3a-1281-a88a-1393e54f26a1@oracle.com>
In-Reply-To: <7c313ae8-6f3a-1281-a88a-1393e54f26a1@oracle.com>

--IMu2UHGcUE6GoRXxvT3hkijSEV94m109Z
Content-Type: multipart/mixed;
 boundary="------------2E3C1A1D1E83919451AF1165"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2E3C1A1D1E83919451AF1165
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 01.03.21 17:16, Boris Ostrovsky wrote:
>=20
> On 3/1/21 9:11 AM, Rafael J. Wysocki wrote:
>> On Sun, Feb 28, 2021 at 2:49 AM Boris Ostrovsky
>> <boris.ostrovsky@oracle.com> wrote:
>>>
>>> On 2/24/21 1:47 PM, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> The ACPI_DEBUG_PRINT() macro is used in a few places in
>>>> xen-acpi-cpuhotplug.c and xen-acpi-memhotplug.c for printing debug
>>>> messages, but that is questionable, because that macro belongs to
>>>> ACPICA and it should not be used elsewhere.  In addition,
>>>> ACPI_DEBUG_PRINT() requires special enabling to allow it to actually=

>>>> print the message and the _COMPONENT symbol generally needed for
>>>> that is not defined in any of the files in question.
>>>>
>>>> For this reason, replace all of the ACPI_DEBUG_PRINT() instances in
>>>> the Xen code with acpi_handle_debug() (with the additional benefit
>>>> that the source object can be identified more easily after this
>>>> change) and drop the ACPI_MODULE_NAME() definitions that are only
>>>> used by the ACPICA message printing macros from that code.
>>>>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> ---
>>>>   drivers/xen/xen-acpi-cpuhotplug.c |   12 +++++-------
>>>>   drivers/xen/xen-acpi-memhotplug.c |   16 +++++++---------
>>>
>>> As I was building with this patch I (re-)discovered that since 2013 i=
t depends on BROKEN (commit 76fc253723add). Despite commit message there =
saying that it's a temporary patch it seems to me by now that it's more t=
han that.
>>>
>>>
>>> And clearly noone tried to build these files since at least 2015 beca=
use memhotplug file doesn't compile due to commit cfafae940381207.
>>>
>>>
>>> While this is easily fixable the question is whether we want to keep =
these files. Obviously noone cares about this functionality.
>> Well, I would be for dropping them.
>>
>> Do you want me to send a patch to do that?
>=20
>=20
> Yes, if you don't mind (but let's give this a few days for people to ha=
ve a chance to comment).

I'm fine with removing those files.


Juergen

--------------2E3C1A1D1E83919451AF1165
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0xB0DE9DD628BF132F.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOBy=
cWx
w3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJvedYm8O=
f8Z
d621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y=
9bf
IhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xq=
G7/
377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR=
3Jv
c3MgPGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsEFgIDA=
QIe
AQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4FUGNQH2lvWAUy+dnyT=
hpw
dtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3TyevpB0CA3dbBQp0OW0fgCetToGIQrg0=
MbD
1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbv=
oPH
Z8SlM4KWm8rG+lIkGurqqu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v=
5QL
+qHI3EIPtyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVyZ=
2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJCAcDAgEGFQgCC=
QoL
BBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4RF7HoZhPVPogNVbC4YA6lW7Dr=
Wf0
teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz78X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC=
/nu
AFVGy+67q2DH8As3KPu0344TBDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0Lh=
ITT
d9jLzdDad1pQSToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLm=
XBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkMnQfvUewRz=
80h
SnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMBAgAjBQJTjHDXAhsDBwsJC=
AcD
AgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJn=
FOX
gMLdBQgBlVPO3/D9R8LtF9DBAFPNhlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1=
jnD
kfJZr6jrbjgyoZHiw/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0=
N51
N5JfVRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwPOoE+l=
otu
fe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK/1xMI3/+8jbO0tsn1=
tqS
EUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuZGU+wsB5BBMBAgAjBQJTjHDrA=
hsD
BwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3=
g3O
ZUEBmDHVVbqMtzwlmNC4k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5=
dM7
wRqzgJpJwK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu5=
D+j
LRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzBTNh30FVKK1Evm=
V2x
AKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37IoN1EblHI//x/e2AaIHpzK5h88N=
Eaw
QsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpW=
nHI
s98ndPUDpnoxWQugJ6MpMncr0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZR=
wgn
BC5mVM6JjQ5xDk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNV=
bVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mmwe0icXKLk=
pEd
IXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0Iv3OOImwTEe4co3c1mwARA=
QAB
wsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMvQ/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEw=
Tbe
8YFsw2V/Buv6Z4Mysln3nQK5ZadD534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1=
vJz
Q1fOU8lYFpZXTXIHb+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8=
VGi
wXvTyJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqcsuylW=
svi
uGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5BjR/i1DG86lem3iBDX=
zXs
ZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------2E3C1A1D1E83919451AF1165--

--IMu2UHGcUE6GoRXxvT3hkijSEV94m109Z--

--Y6WqBR9s8HPASVufSY807FC9ROBrepWk0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmA9Pe4FAwAAAAAACgkQsN6d1ii/Ey/X
Xwf/T5pILtrP2Vss5K6gmbbQFUxpMalP1uWUEX87zmFAKMOaiivPnoqmUw6FAyS88slClsPNlwOf
kXPGM2fx4EbVWbinGHHm8LZlWQZLKVeJSGbieq+mKSnbnq5XIkksC1VHjfD8D3/tEmSSvSVfuYuo
PYja1K2LFCdQtAtzi0VXqqUTttDNLiJT6oTtsiJHvAoE1CXTdBiVZju0UrTLKIVbJpxccooRgVCR
/XT3SBsWrnb15J1JyApNIMtJ/P36In17JunTv8U7UcOjC1liH94XvXOQsrO+XzxJNFSW1Dz2Q3Mm
zSXwdlv1I9IYl414ZVdzJ2U+UAxW1zv/TmEusYJtbQ==
=baql
-----END PGP SIGNATURE-----

--Y6WqBR9s8HPASVufSY807FC9ROBrepWk0--
